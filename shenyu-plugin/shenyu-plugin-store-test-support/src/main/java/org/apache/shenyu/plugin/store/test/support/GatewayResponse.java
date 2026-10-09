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

package org.apache.shenyu.plugin.store.test.support;

import org.springframework.http.HttpHeaders;

/**
 * Immutable response returned by a real gateway HTTP request.
 */
public final class GatewayResponse {

    private final int statusCode;

    private final HttpHeaders headers;

    private final String body;

    GatewayResponse(final int statusCode, final HttpHeaders headers, final String body) {
        this.statusCode = statusCode;
        this.headers = headers;
        this.body = body;
    }

    /**
     * HTTP status code.
     *
     * @return status code
     */
    public int getStatusCode() {
        return statusCode;
    }

    /**
     * HTTP response headers.
     *
     * @return headers
     */
    public HttpHeaders getHeaders() {
        return headers;
    }

    /**
     * HTTP response body.
     *
     * @return body
     */
    public String getBody() {
        return body;
    }
}
