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

package org.apache.shenyu.plugin.sofa.cache;

import org.apache.shenyu.common.dto.convert.selector.CommonUpstream;

import java.util.Objects;

/**
 * SOFA selector upstream data used by the store plugin.
 */
public final class SofaUpstream extends CommonUpstream {

    private String register;

    private String appName;

    private int port;

    private int weight;

    private int warmup;

    /**
     * Gets the registry address.
     *
     * @return registry address
     */
    public String getRegister() {
        return register;
    }

    /**
     * Sets the registry address.
     *
     * @param register registry address
     */
    public void setRegister(final String register) {
        this.register = register;
    }

    /**
     * Gets the SOFA application name.
     *
     * @return SOFA application name
     */
    public String getAppName() {
        return appName;
    }

    /**
     * Sets the SOFA application name.
     *
     * @param appName SOFA application name
     */
    public void setAppName(final String appName) {
        this.appName = appName;
    }

    /**
     * Gets the upstream port.
     *
     * @return upstream port
     */
    public int getPort() {
        return port;
    }

    /**
     * Sets the upstream port.
     *
     * @param port upstream port
     */
    public void setPort(final int port) {
        this.port = port;
    }

    /**
     * Gets the upstream weight.
     *
     * @return upstream weight
     */
    public int getWeight() {
        return weight;
    }

    /**
     * Sets the upstream weight.
     *
     * @param weight upstream weight
     */
    public void setWeight(final int weight) {
        this.weight = weight;
    }

    /**
     * Gets the warmup seconds.
     *
     * @return warmup seconds
     */
    public int getWarmup() {
        return warmup;
    }

    /**
     * Sets the warmup seconds.
     *
     * @param warmup warmup seconds
     */
    public void setWarmup(final int warmup) {
        this.warmup = warmup;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof SofaUpstream)) {
            return false;
        }
        SofaUpstream that = (SofaUpstream) o;
        return port == that.port
                && weight == that.weight
                && warmup == that.warmup
                && Objects.equals(register, that.register)
                && Objects.equals(appName, that.appName)
                && Objects.equals(getProtocol(), that.getProtocol())
                && Objects.equals(getUpstreamUrl(), that.getUpstreamUrl())
                && Objects.equals(isGray(), that.isGray())
                && Objects.equals(isStatus(), that.isStatus())
                && Objects.equals(getTimestamp(), that.getTimestamp());
    }

    @Override
    public int hashCode() {
        return Objects.hash(register, appName, port, weight, warmup, getProtocol(), getUpstreamUrl(), isGray(), isStatus(), getTimestamp());
    }

    @Override
    public String toString() {
        return "SofaUpstream{"
                + "register='" + register + '\''
                + ", appName='" + appName + '\''
                + ", protocol='" + getProtocol() + '\''
                + ", port=" + port
                + ", upstreamUrl='" + getUpstreamUrl() + '\''
                + ", gray=" + isGray()
                + ", weight=" + weight
                + ", warmup=" + warmup
                + ", status=" + isStatus()
                + ", timestamp=" + getTimestamp()
                + '}';
    }
}
