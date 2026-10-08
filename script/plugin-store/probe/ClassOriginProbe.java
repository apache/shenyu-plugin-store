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

package org.apache.shenyu.plugin.store.harness;

import java.security.CodeSource;

public final class ClassOriginProbe {

    private ClassOriginProbe() {
    }

    public static void main(final String[] args) throws Exception {
        if (args.length < 2) {
            throw new IllegalArgumentException("Usage: ClassOriginProbe <class-name> <expected-code-source-fragment>");
        }
        Class<?> target = Class.forName(args[0]);
        CodeSource codeSource = target.getProtectionDomain().getCodeSource();
        String location = codeSource == null ? "" : codeSource.getLocation().toString();
        System.out.println(args[0] + "=" + location);
        if (!location.contains(args[1])) {
            throw new IllegalStateException("Expected " + args[0] + " to load from " + args[1] + " but was " + location);
        }
    }
}
