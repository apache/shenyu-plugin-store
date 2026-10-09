/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.shenyu.plugin.casdoor;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.sun.net.httpserver.HttpServer;
import org.apache.shenyu.common.config.ShenyuConfig;
import org.apache.shenyu.common.dto.PluginData;
import org.apache.shenyu.common.enums.PluginEnum;
import org.apache.shenyu.common.utils.GsonUtils;
import org.apache.shenyu.plugin.api.ShenyuPlugin;
import org.apache.shenyu.plugin.api.ShenyuPluginChain;
import org.apache.shenyu.plugin.api.result.DefaultShenyuResult;
import org.apache.shenyu.plugin.api.result.ShenyuResult;
import org.apache.shenyu.plugin.api.utils.SpringBeanUtils;
import org.apache.shenyu.plugin.base.cache.MatchDataCache;
import org.apache.shenyu.plugin.casdoor.handle.CasdoorPluginDateHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.GatewayResponse;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.net.InetSocketAddress;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.interfaces.RSAPrivateKey;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/**
 * Gateway-level tests for the externalized Casdoor plugin artifact.
 */
public final class CasdoorGatewayE2ETest {

    private final HttpClient httpClient = HttpClient.newHttpClient();

    @BeforeEach
    public void setUp() {
        ConfigurableApplicationContext context = mock(ConfigurableApplicationContext.class);
        when(context.getBean(ShenyuConfig.class)).thenReturn(new ShenyuConfig());
        when(context.getBean(ShenyuResult.class)).thenReturn(new DefaultShenyuResult());
        SpringBeanUtils.getInstance().setApplicationContext(context);
        GatewayFixtures.cleanBaseDataCache();
        MatchDataCache.getInstance().cleanSelectorData();
        MatchDataCache.getInstance().cleanRuleDataData();
    }

    @AfterEach
    public void cleanUp() {
        GatewayFixtures.cleanBaseDataCache();
        MatchDataCache.getInstance().cleanSelectorData();
        MatchDataCache.getInstance().cleanRuleDataData();
    }

    @Test
    public void testGatewayAuthorizesSignedJwtAndPropagatesIdentityHeaders() throws Exception {
        CasdoorPlugin plugin = new CasdoorPlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}");
        TestKeyMaterial keyMaterial = TestKeyMaterial.create();
        configureCasdoor(keyMaterial, "http://127.0.0.1:1");
        String token = keyMaterial.token("organization-a", "alice", "user-a");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, new IdentityTerminalPlugin()))) {
            SimpleResponse response = get(server, "/casdoor", token);
            assertThat(response.statusCode).isEqualTo(HttpStatus.OK.value());
            assertThat(response.body).isEqualTo("alice|user-a|organization-a");
        }
    }

    @Test
    public void testGatewayRejectsMissingAndInvalidTokensBeforeTerminal() throws Exception {
        CasdoorPlugin plugin = new CasdoorPlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}");
        configureCasdoor(TestKeyMaterial.create(), "http://127.0.0.1:1");
        CountingTerminalPlugin terminal = new CountingTerminalPlugin();
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, terminal))) {
            GatewayResponse missing = server.get("/casdoor");
            SimpleResponse invalid = get(server, "/casdoor", "not-a-jwt");
            assertThat(missing.getBody()).contains("Illegal authorization");
            assertThat(invalid.statusCode).isNotEqualTo(HttpStatus.OK.value());
            assertThat(terminal.invocations).isZero();
        }
    }

    @Test
    public void testGatewayCallbackUsesLocalCasdoorTokenEndpoint() throws Exception {
        CasdoorPlugin plugin = new CasdoorPlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}");
        TestKeyMaterial keyMaterial = TestKeyMaterial.create();
        String token = keyMaterial.token("callback-org", "callback-user", "callback-id");
        try (LocalTokenEndpoint endpoint = LocalTokenEndpoint.start(token)) {
            configureCasdoor(keyMaterial, endpoint.baseUrl());
            try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, new IdentityTerminalPlugin()))) {
                GatewayResponse response = server.get("/callback?code=local-code&state=local-state");
                assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK.value());
                assertThat(response.getBody()).isEqualTo("callback-user|callback-id|callback-org");
                assertThat(endpoint.requests).isEqualTo(1);
            }
        }
    }

    @Test
    public void testGatewayPluginConfigRefreshReplacesCertificate() throws Exception {
        CasdoorPlugin plugin = new CasdoorPlugin();
        GatewayFixtures.cachePluginRoute(plugin, "{}");
        TestKeyMaterial first = TestKeyMaterial.create();
        TestKeyMaterial second = TestKeyMaterial.create();
        String firstToken = first.token("first-org", "first-user", "first-id");
        String secondToken = second.token("second-org", "second-user", "second-id");
        configureCasdoor(first, "http://127.0.0.1:1");
        try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, new IdentityTerminalPlugin()))) {
            assertThat(get(server, "/refresh", firstToken).body).isEqualTo("first-user|first-id|first-org");
            configureCasdoor(second, "http://127.0.0.1:1");
            assertThat(get(server, "/refresh", firstToken).statusCode).isNotEqualTo(HttpStatus.OK.value());
            SimpleResponse refreshed = get(server, "/refresh", secondToken);
            assertThat(refreshed.statusCode).isEqualTo(HttpStatus.OK.value());
            assertThat(refreshed.body).isEqualTo("second-user|second-id|second-org");
        }
    }

    private void configureCasdoor(final TestKeyMaterial keyMaterial, final String endpoint) {
        Map<String, String> config = new LinkedHashMap<>();
        config.put("endpoint", endpoint);
        config.put("client_id", "local-client");
        config.put("client_secrect", "local-secret");
        config.put("certificate", keyMaterial.certificatePem);
        config.put("organization-name", "local-org");
        config.put("application-name", "local-app");
        PluginData pluginData = new PluginData("pluginId", PluginEnum.CASDOOR.getName(),
                GsonUtils.getInstance().toJson(config), "0", true, null);
        new CasdoorPluginDateHandler().handlerPlugin(pluginData);
    }

    private SimpleResponse get(final ShenyuGatewayTestServer server, final String path, final String token) throws Exception {
        HttpRequest request = HttpRequest.newBuilder(URI.create(server.baseUrl() + path))
                .header(HttpHeaders.AUTHORIZATION, token)
                .GET()
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new SimpleResponse(response.statusCode(), response.body());
    }

    private static String header(final ServerWebExchange exchange, final String name) {
        return exchange.getRequest().getHeaders().getFirst(name);
    }

    private static Mono<Void> write(final ServerWebExchange exchange, final String body) {
        final byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponse().setStatusCode(HttpStatus.OK);
        exchange.getResponse().getHeaders().setContentType(MediaType.TEXT_PLAIN);
        exchange.getResponse().getHeaders().setContentLength(bytes.length);
        final DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(bytes);
        return exchange.getResponse().writeWith(Mono.just(buffer));
    }

    private static String certificatePem(final KeyPair keyPair) throws Exception {
        byte[] algorithm = derSequence(derObjectId("1.2.840.113549.1.1.11"), derNull());
        byte[] name = derSequence(derSet(derSequence(derObjectId("2.5.4.3"), derUtf8String("shenyu-store-test"))));
        byte[] validity = derSequence(derUtcTime(Instant.now().minusSeconds(60)), derUtcTime(Instant.now().plusSeconds(3600)));
        byte[] tbsCertificate = derSequence(
                derInteger(BigInteger.valueOf(Math.abs(new SecureRandom().nextLong()))),
                algorithm,
                name,
                validity,
                name,
                keyPair.getPublic().getEncoded());
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(keyPair.getPrivate());
        signature.update(tbsCertificate);
        byte[] certificate = derSequence(tbsCertificate, algorithm, derBitString(signature.sign()));
        return "-----BEGIN CERTIFICATE-----\n"
                + java.util.Base64.getMimeEncoder(64, new byte[] {'\n'}).encodeToString(certificate)
                + "\n-----END CERTIFICATE-----\n";
    }

    private static byte[] derSequence(final byte[]... values) throws IOException {
        return der((byte) 0x30, concat(values));
    }

    private static byte[] derSet(final byte[]... values) throws IOException {
        return der((byte) 0x31, concat(values));
    }

    private static byte[] derInteger(final BigInteger value) throws IOException {
        return der((byte) 0x02, value.toByteArray());
    }

    private static byte[] derObjectId(final String value) throws IOException {
        String[] parts = value.split("\\.");
        ByteArrayOutputStream body = new ByteArrayOutputStream();
        body.write(Integer.parseInt(parts[0]) * 40 + Integer.parseInt(parts[1]));
        for (int i = 2; i < parts.length; i++) {
            writeBase128(body, Long.parseLong(parts[i]));
        }
        return der((byte) 0x06, body.toByteArray());
    }

    private static byte[] derNull() throws IOException {
        return der((byte) 0x05, new byte[0]);
    }

    private static byte[] derUtf8String(final String value) throws IOException {
        return der((byte) 0x0c, value.getBytes(StandardCharsets.UTF_8));
    }

    private static byte[] derUtcTime(final Instant instant) throws IOException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss'Z'").withZone(ZoneOffset.UTC);
        return der((byte) 0x17, formatter.format(instant).getBytes(StandardCharsets.US_ASCII));
    }

    private static byte[] derBitString(final byte[] value) throws IOException {
        byte[] body = new byte[value.length + 1];
        System.arraycopy(value, 0, body, 1, value.length);
        return der((byte) 0x03, body);
    }

    private static byte[] der(final byte tag, final byte[] body) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        out.write(tag);
        writeLength(out, body.length);
        out.write(body);
        return out.toByteArray();
    }

    private static byte[] concat(final byte[]... values) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        for (byte[] value : values) {
            out.write(value);
        }
        return out.toByteArray();
    }

    private static void writeLength(final ByteArrayOutputStream out, final int length) {
        if (length < 128) {
            out.write(length);
            return;
        }
        int size = Integer.BYTES - Integer.numberOfLeadingZeros(length) / Byte.SIZE;
        out.write(0x80 | size);
        for (int i = size - 1; i >= 0; i--) {
            out.write(length >> i * Byte.SIZE & 0xff);
        }
    }

    private static void writeBase128(final ByteArrayOutputStream out, final long value) {
        int size = Long.BYTES - Long.numberOfLeadingZeros(value) / Byte.SIZE;
        byte[] stack = new byte[Math.max(1, size + 1)];
        int pos = stack.length;
        long remaining = value;
        stack[--pos] = (byte) (remaining & 0x7f);
        remaining >>= 7;
        while (remaining > 0) {
            stack[--pos] = (byte) (remaining & 0x7f | 0x80);
            remaining >>= 7;
        }
        out.write(stack, pos, stack.length - pos);
    }

    private static final class IdentityTerminalPlugin implements ShenyuPlugin {

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            String body = String.join("|", header(exchange, "name"), header(exchange, "id"), header(exchange, "organization"));
            return write(exchange, body);
        }

        @Override
        public int getOrder() {
            return Integer.MAX_VALUE - 1;
        }

        @Override
        public String named() {
            return "casdoor-identity-terminal";
        }
    }

    private static final class CountingTerminalPlugin implements ShenyuPlugin {

        private int invocations;

        @Override
        public Mono<Void> execute(final ServerWebExchange exchange, final ShenyuPluginChain chain) {
            invocations++;
            return write(exchange, "unexpected");
        }

        @Override
        public int getOrder() {
            return Integer.MAX_VALUE - 1;
        }

        @Override
        public String named() {
            return "casdoor-counting-terminal";
        }
    }

    private static final class SimpleResponse {

        private final int statusCode;

        private final String body;

        private SimpleResponse(final int statusCode, final String body) {
            this.statusCode = statusCode;
            this.body = body;
        }
    }

    private static final class LocalTokenEndpoint implements AutoCloseable {

        private final HttpServer server;

        private int requests;

        private LocalTokenEndpoint(final HttpServer server) {
            this.server = server;
        }

        private static LocalTokenEndpoint start(final String token) throws IOException {
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
            LocalTokenEndpoint endpoint = new LocalTokenEndpoint(server);
            server.createContext("/api/login/oauth/access_token", exchange -> {
                endpoint.requests++;
                String body = "{\"access_token\":\"" + token + "\",\"token_type\":\"Bearer\",\"expires_in\":3600}";
                byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
                exchange.getResponseHeaders().set("Content-Type", "application/json;charset=UTF-8");
                exchange.sendResponseHeaders(HttpStatus.OK.value(), bytes.length);
                exchange.getResponseBody().write(bytes);
                exchange.close();
            });
            server.start();
            return endpoint;
        }

        private String baseUrl() {
            return "http://127.0.0.1:" + server.getAddress().getPort();
        }

        @Override
        public void close() {
            server.stop(0);
        }
    }

    private static final class TestKeyMaterial {

        private final PrivateKey privateKey;

        private final String certificatePem;

        private TestKeyMaterial(final PrivateKey privateKey, final String certificatePem) {
            this.privateKey = privateKey;
            this.certificatePem = certificatePem;
        }

        private static TestKeyMaterial create() throws Exception {
            KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(2048, new SecureRandom());
            KeyPair keyPair = generator.generateKeyPair();
            String certificate = certificatePem(keyPair);
            return new TestKeyMaterial(keyPair.getPrivate(), certificate);
        }

        private String token(final String owner, final String name, final String id) throws Exception {
            JWTClaimsSet claims = new JWTClaimsSet.Builder()
                    .claim("owner", owner)
                    .claim("name", name)
                    .claim("id", id)
                    .issueTime(new Date())
                    .expirationTime(Date.from(Instant.now().plusSeconds(300)))
                    .build();
            SignedJWT jwt = new SignedJWT(new JWSHeader(JWSAlgorithm.RS256), claims);
            jwt.sign(new RSASSASigner((RSAPrivateKey) privateKey));
            return jwt.serialize();
        }
    }

}
