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

package org.apache.shenyu.plugin.motan.k8s;

/**
 * Motan ingress annotations.
 */
public final class MotanIngressConstants {

    public static final String METADATA_LABEL_PREFIX = "shenyu.apache.org/metadata-labels-";

    public static final String PLUGIN_MOTAN_ENABLED = "shenyu.apache.org/plugin-motan-enabled";

    public static final String PLUGIN_MOTAN_APP_NAME = "shenyu.apache.org/plugin-motan-app-name";

    public static final String PLUGIN_MOTAN_METHOD_NAME = "shenyu.apache.org/plugin-motan-method-name";

    public static final String PLUGIN_MOTAN_PATH = "shenyu.apache.org/plugin-motan-path";

    public static final String PLUGIN_MOTAN_RPC_TYPE = "shenyu.apache.org/plugin-motan-rpc-type";

    public static final String PLUGIN_MOTAN_SERVICE_NAME = "shenyu.apache.org/plugin-motan-service-name";

    public static final String PLUGIN_MOTAN_CONTEXT_PATH = "shenyu.apache.org/plugin-motan-context-path";

    public static final String PLUGIN_MOTAN_RPC_EXPAND = "shenyu.apache.org/plugin-motan-rpc-expand";

    public static final String PLUGIN_MOTAN_PARAMS_TYPE = "shenyu.apache.org/plugin-motan-params-type";

    public static final String ZOOKEEPER_REGISTER_ADDRESS = "shenyu.apache.org/zookeeper-register-address";

    public static final String PLUGIN_MOTAN_REGISTER_PROTOCOL = "shenyu.apache.org/plugin-motan-register-protocol";

    public static final String PLUGIN_MOTAN_DIRECT_URL = "shenyu.apache.org/plugin-motan-direct-url";

    public static final String PLUGIN_MOTAN_PROTOCOL = "shenyu.apache.org/plugin-motan-protocol";

    public static final String PLUGIN_MOTAN_SERIALIZATION = "shenyu.apache.org/plugin-motan-serialization";

    public static final String PLUGIN_MOTAN_THREADPOOL = "shenyu.apache.org/plugin-motan-threadpool";

    public static final String PLUGIN_MOTAN_CORETHREADS = "shenyu.apache.org/plugin-motan-corethreads";

    public static final String PLUGIN_MOTAN_THREADS = "shenyu.apache.org/plugin-motan-threads";

    public static final String PLUGIN_MOTAN_QUEUES = "shenyu.apache.org/plugin-motan-queues";

    public static final String DEFAULT_RPC_EXT = "{\"group\":\"\",\"timeout\":1000,\"rpcProtocol\":\"motan2\"}";

    private MotanIngressConstants() {
    }
}
