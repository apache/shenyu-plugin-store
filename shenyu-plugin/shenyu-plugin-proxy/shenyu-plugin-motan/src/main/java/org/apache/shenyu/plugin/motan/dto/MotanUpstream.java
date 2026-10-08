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

package org.apache.shenyu.plugin.motan.dto;

import java.util.Objects;

/**
 * Motan selector upstream settings.
 */
public class MotanUpstream {

    private String protocol;

    private String registerProtocol;

    private String registerAddress;

    private String directUrl;

    private String serialization;

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(final String protocol) {
        this.protocol = protocol;
    }

    public String getRegisterProtocol() {
        return registerProtocol;
    }

    public void setRegisterProtocol(final String registerProtocol) {
        this.registerProtocol = registerProtocol;
    }

    public String getRegisterAddress() {
        return registerAddress;
    }

    public void setRegisterAddress(final String registerAddress) {
        this.registerAddress = registerAddress;
    }

    public String getDirectUrl() {
        return directUrl;
    }

    public void setDirectUrl(final String directUrl) {
        this.directUrl = directUrl;
    }

    public String getSerialization() {
        return serialization;
    }

    public void setSerialization(final String serialization) {
        this.serialization = serialization;
    }

    @Override
    public boolean equals(final Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof MotanUpstream)) {
            return false;
        }
        MotanUpstream that = (MotanUpstream) other;
        return Objects.equals(protocol, that.protocol)
                && Objects.equals(registerProtocol, that.registerProtocol)
                && Objects.equals(registerAddress, that.registerAddress)
                && Objects.equals(directUrl, that.directUrl)
                && Objects.equals(serialization, that.serialization);
    }

    @Override
    public int hashCode() {
        return Objects.hash(protocol, registerProtocol, registerAddress, directUrl, serialization);
    }
}
