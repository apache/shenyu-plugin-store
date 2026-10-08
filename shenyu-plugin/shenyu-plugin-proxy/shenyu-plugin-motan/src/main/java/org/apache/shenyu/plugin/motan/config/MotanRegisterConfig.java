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

package org.apache.shenyu.plugin.motan.config;

import java.io.Serializable;
import java.util.Objects;

/**
 * Motan plugin register config.
 */
public class MotanRegisterConfig implements Serializable {

    private static final long serialVersionUID = 2488053756247710408L;

    private String registerProtocol;

    private String registerAddress;

    private String threadpool;

    private Integer corethreads;

    private Integer threads;

    private Integer queues;

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

    public String getThreadpool() {
        return threadpool;
    }

    public void setThreadpool(final String threadpool) {
        this.threadpool = threadpool;
    }

    public Integer getCorethreads() {
        return corethreads;
    }

    public void setCorethreads(final Integer corethreads) {
        this.corethreads = corethreads;
    }

    public Integer getThreads() {
        return threads;
    }

    public void setThreads(final Integer threads) {
        this.threads = threads;
    }

    public Integer getQueues() {
        return queues;
    }

    public void setQueues(final Integer queues) {
        this.queues = queues;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (Objects.isNull(o) || getClass() != o.getClass()) {
            return false;
        }
        MotanRegisterConfig that = (MotanRegisterConfig) o;
        return Objects.equals(registerProtocol, that.registerProtocol)
                && Objects.equals(registerAddress, that.registerAddress)
                && Objects.equals(threadpool, that.threadpool)
                && Objects.equals(corethreads, that.corethreads)
                && Objects.equals(threads, that.threads)
                && Objects.equals(queues, that.queues);
    }

    @Override
    public int hashCode() {
        return Objects.hash(registerProtocol, registerAddress, threadpool, corethreads, threads, queues);
    }

    @Override
    public String toString() {
        return "MotanRegisterConfig{"
                + "registerProtocol='"
                + registerProtocol
                + '\''
                + ", registerAddress='"
                + registerAddress
                + '\''
                + ", threadpool='"
                + threadpool
                + '\''
                + ", corethreads='"
                + corethreads
                + '\''
                + ", threads='"
                + threads
                + '\''
                + ", queues='"
                + queues
                + '\''
                + '}';
    }
}
