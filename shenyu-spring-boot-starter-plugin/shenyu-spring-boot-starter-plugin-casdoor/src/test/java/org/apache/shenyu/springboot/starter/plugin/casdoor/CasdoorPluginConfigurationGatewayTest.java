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

package org.apache.shenyu.springboot.starter.plugin.casdoor;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
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
import org.apache.shenyu.plugin.base.handler.PluginDataHandler;
import org.apache.shenyu.plugin.store.test.support.GatewayFixtures;
import org.apache.shenyu.plugin.store.test.support.ShenyuGatewayTestServer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.AutoConfigurations;
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
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
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
 * Gateway-level test for the Casdoor Spring Boot starter.
 */
public final class CasdoorPluginConfigurationGatewayTest {

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
    public void testStarterCreatedPluginAuthenticatesSignedJwtThroughGateway() {
        ShenyuGatewayTestServer.contextRunner()
                .withConfiguration(AutoConfigurations.of(CasdoorPluginConfiguration.class))
                .run(context -> {
                    ShenyuPlugin plugin = context.getBean(ShenyuPlugin.class);
                    PluginDataHandler handler = context.getBean(PluginDataHandler.class);
                    TestKeyMaterial keyMaterial = TestKeyMaterial.create();
                    handler.handlerPlugin(pluginData(keyMaterial));
                    GatewayFixtures.cachePluginRoute(plugin, "{}");
                    try (ShenyuGatewayTestServer server = ShenyuGatewayTestServer.start(Arrays.asList(plugin, new IdentityTerminalPlugin()))) {
                        HttpRequest request = HttpRequest.newBuilder(URI.create(server.baseUrl() + "/starter"))
                                .header(HttpHeaders.AUTHORIZATION, keyMaterial.token())
                                .GET()
                                .build();
                        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
                        assertThat(response.statusCode()).isEqualTo(HttpStatus.OK.value());
                        assertThat(response.body()).isEqualTo("starter-user|starter-id|starter-org");
                    }
                });
    }

    private PluginData pluginData(final TestKeyMaterial keyMaterial) {
        Map<String, String> config = new LinkedHashMap<>();
        config.put("endpoint", "http://127.0.0.1:1");
        config.put("client_id", "local-client");
        config.put("client_secrect", "local-secret");
        config.put("certificate", keyMaterial.certificatePem);
        config.put("organization-name", "local-org");
        config.put("application-name", "local-app");
        return new PluginData("pluginId", PluginEnum.CASDOOR.getName(), GsonUtils.getInstance().toJson(config), "0", true, null);
    }

    private static String header(final ServerWebExchange exchange, final String name) {
        return exchange.getRequest().getHeaders().getFirst(name);
    }

    private static String certificatePem(final KeyPair keyPair) throws Exception {
        byte[] algorithm = derSequence(derObjectId("1.2.840.113549.1.1.11"), derNull());
        byte[] name = derSequence(derSet(derSequence(derObjectId("2.5.4.3"), derUtf8String("shenyu-store-test"))));
        byte[] validity = derSequence(derUtcTime(Instant.now().minusSeconds(60)), derUtcTime(Instant.now().plusSeconds(3600)));
        byte[] tbsCertificate = derSequence(derInteger(BigInteger.valueOf(Math.abs(new SecureRandom().nextLong()))), algorithm,
                name, validity, name, keyPair.getPublic().getEncoded());
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
        byte[] stack = new byte[Long.BYTES + 1];
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
            final byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
            exchange.getResponse().setStatusCode(HttpStatus.OK);
            exchange.getResponse().getHeaders().setContentType(MediaType.TEXT_PLAIN);
            exchange.getResponse().getHeaders().setContentLength(bytes.length);
            final DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(bytes);
            return exchange.getResponse().writeWith(Mono.just(buffer));
        }

        @Override
        public int getOrder() {
            return Integer.MAX_VALUE - 1;
        }

        @Override
        public String named() {
            return "casdoor-starter-identity-terminal";
        }
    }

    private static final class TestKeyMaterial {

        private final RSAPrivateKey privateKey;

        private final String certificatePem;

        private TestKeyMaterial(final RSAPrivateKey privateKey, final String certificatePem) {
            this.privateKey = privateKey;
            this.certificatePem = certificatePem;
        }

        private static TestKeyMaterial create() throws Exception {
            KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(2048, new SecureRandom());
            KeyPair keyPair = generator.generateKeyPair();
            return new TestKeyMaterial((RSAPrivateKey) keyPair.getPrivate(), certificatePem(keyPair));
        }

        private String token() throws Exception {
            JWTClaimsSet claims = new JWTClaimsSet.Builder()
                    .claim("owner", "starter-org")
                    .claim("name", "starter-user")
                    .claim("id", "starter-id")
                    .issueTime(new Date())
                    .expirationTime(Date.from(Instant.now().plusSeconds(300)))
                    .build();
            SignedJWT jwt = new SignedJWT(new JWSHeader(JWSAlgorithm.RS256), claims);
            jwt.sign(new RSASSASigner(privateKey));
            return jwt.serialize();
        }
    }

}
