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

package org.apache.shenyu.plugin.motan.constant;

/**
 * Motan plugin constants owned by the external plugin.
 */
public final class MotanPluginConstants {

    /**
     * Motan plugin name and rpc type.
     */
    public static final String MOTAN = "motan";

    /**
     * Motan plugin order kept compatible with ShenYu 2.7.0.
     */
    public static final int MOTAN_PLUGIN_ORDER = 310;

    /**
     * Old ShenYu result code for missing Motan body parameters.
     */
    public static final int MOTAN_HAVE_BODY_PARAM_CODE = 437;

    /**
     * Old ShenYu result message for missing Motan body parameters.
     */
    public static final String MOTAN_HAVE_BODY_PARAM_MESSAGE = "Motan must have body param, please enter the JSON format in the body!";

    /**
     * Empty Motan RPC result text kept compatible with ShenYu 2.7.0.
     */
    public static final String MOTAN_RPC_RESULT_EMPTY = "motan has not return value!";

    private MotanPluginConstants() {
    }
}
