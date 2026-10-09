![Light Logo](https://raw.githubusercontent.com/apache/shenyu-website/main/static/img/logo-light.svg#gh-dark-mode-only)
![Dark Logo](https://raw.githubusercontent.com/apache/shenyu-website/main/static/img/logo.svg#gh-light-mode-only)

<p align="center">
  <strong>Scalable, High Performance, Responsive API Gateway Solution for all MicroServices</strong>
</p>
<p align="center">
  <a href="https://shenyu.apache.org/">https://shenyu.apache.org/</a>
</p>

<p align="center">
  <a href="https://shenyu.apache.org/docs/index" >
    <img src="https://img.shields.io/badge/document-English-blue.svg" alt="EN docs" />
  </a>
  <a href="https://shenyu.apache.org/zh/docs/index">
    <img src="https://img.shields.io/badge/文档-简体中文-blue.svg" alt="简体中文文档" />
  </a>
</p>

<p align="center">
    <a target="_blank" href="https://search.maven.org/search?q=g:org.apache.shenyu%20AND%20a:shenyu">
        <img src="https://img.shields.io/maven-central/v/org.apache.shenyu/shenyu.svg?label=maven%20central" />
    </a>
    <a target="_blank" href="https://github.com/apache/shenyu/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?label=license" />
    </a>
    <a target="_blank" href="https://www.oracle.com/technetwork/java/javase/downloads/index.html">
        <img src="https://img.shields.io/badge/JDK-17+-green.svg" />
    </a>
    <a target="_blank" href="https://github.com/apache/shenyu/actions">
        <img src="https://github.com/apache/shenyu/workflows/ci/badge.svg" />
    </a>
   <a target="_blank" href='https://github.com/apache/shenyu'>
        <img src="https://img.shields.io/github/forks/apache/shenyu.svg" alt="github forks"/>
   </a>
   <a target="_blank" href='https://github.com/apache/shenyu'>
        <img src="https://img.shields.io/github/stars/apache/shenyu.svg" alt="github stars"/>
   </a>
   <a target="_blank" href='https://github.com/apache/shenyu'>
        <img src="https://img.shields.io/github/contributors/apache/shenyu.svg" alt="github contributors"/>
   </a>
   <a target="_blank" href="https://codecov.io/gh/apache/shenyu">
        <img src="https://codecov.io/gh/apache/shenyu/branch/master/graph/badge.svg" />
   </a>
  <a target="_blank" href="https://hub.docker.com/r/apache/shenyu-bootstrap/tags">
    <image src="https://img.shields.io/docker/pulls/apache/shenyu-bootstrap" alt="Docker Pulls"/>
  </a>
  <a target="_blank" href="https://gitpod.io/#https://github.com/apache/shenyu">
    <image src="https://img.shields.io/badge/Contribute%20with-Gitpod-908a85?logo=gitpod&color=green"/>
  </a>
  <a target="_blank" href="https://deepwiki.com/apache/shenyu">
    <img src="https://deepwiki.com/badge.svg" alt="Ask DeepWiki">
  </a>
</p>
<br/>

---

# Architecture
 
 ![](https://shenyu.apache.org/img/architecture/shenyu-architecture-3d.png)  
 
---- 

# Why named Apache ShenYu

ShenYu (神禹) is the honorific name of Chinese ancient monarch Xia Yu (also known in later times as Da Yu), 
who left behind the touching story of the three times he crossed the Yellow River for the benefit of the people and successfully managed the flooding of the river. 
He is known as one of the three greatest kings of ancient China, along with Yao and Shun.

   * Firstly, the name ShenYu is to promote the traditional virtues of our Chinese civilisation.

   * Secondly, the most important thing about the gateway is the governance of the traffic.

   * Finally, the community will do things in a fair, just, open and meritocratic way, paying tribute to ShenYu while also conforming to the Apache Way.

--- 

# Features

* Proxy: Support for Apache® Dubbo™, Spring Cloud, gRPC, Motan, SOFA, TARS, WebSocket, MQTT
* Security: Sign, OAuth 2.0, JSON Web Tokens, WAF plugin
* API governance: Request, response, parameter mapping, Hystrix, RateLimiter plugin
* Observability: Tracing, metrics, logging plugin
* Dashboard: Dynamic traffic control, visual backend for user menu permissions
* Extensions: Plugin hot-swapping, dynamic loading
* Cluster: NGINX, Docker, Kubernetes
* Language: provides .NET, Python, Go, Java client for API register

---

# Motan plugin support

The Motan gateway plugin is maintained as an external plugin in this repository. It is not restored to ShenYu core and does not require Motan-specific core enums, DTOs, result codes, or distribution artifacts. A bootstrap consumes it by adding the Motan plugin and starter artifacts explicitly.

Current verification uses the real Motan 1.2.1 runtime with ShenYu 2.7.0 and 2.7.2-SNAPSHOT plugin APIs on Java 17. The gateway integration coverage starts a Motan provider, invokes it through ShenYu, rejects invalid request body or metadata, refreshes direct upstream configuration, and checks old Motan references are closed. The integration fixture uses Motan's `simple` serialization because Motan 1.2.1 Hessian2 is not Java 17 friendly for these request and error payloads.

Client-side Motan registration is not provided by this external plugin. Configure plugin data, selectors, rules, and metadata through the supported ShenYu admin/config channel; the gateway continues to consume config through normal data sync. To roll back, remove the Motan starter/plugin artifacts from the bootstrap classpath, disable or delete Motan plugin config and Motan metadata in admin, then restart any bootstrap that had loaded the external plugin. Historical release notes and upgrade SQL remain historical records.

---  

# Quick Start (docker)

### Create network for Shenyu

```
> docker network create shenyu
```

### Run Apache ShenYu Admin

```
> docker pull apache/shenyu-admin
> docker run -d --name shenyu-admin-quickstart -p 9095:9095 --net shenyu apache/shenyu-admin
```

### Run Apache ShenYu Bootstrap

```
> docker pull apache/shenyu-bootstrap
> docker run -d --name shenyu-quickstart -p 9195:9195 -e "shenyu.local.enabled=true" -e SHENYU_SYNC_WEBSOCKET_URLS=ws://shenyu-admin-quickstart:9095/websocket --net shenyu apache/shenyu-bootstrap
```                       

### Set router

* Real request  ：http://127.0.0.1:8080/helloworld,

```json
{
  "name" : "Shenyu",
  "data" : "hello world"
}
```

* Set routing rules (Standalone)

Add `localKey: 123456` to Headers. If you need to customize the localKey, you can use the sha512 tool to generate the key based on plaintext and update the `shenyu.local.sha512Key` property.

```
curl --location --request POST 'http://localhost:9195/shenyu/plugin/selectorAndRules' \
--header 'Content-Type: application/json' \
--header 'localKey: 123456' \
--data-raw '{
    "pluginName": "divide",
    "selectorHandler": "[{\"upstreamUrl\":\"127.0.0.1:8080\"}]",
    "conditionDataList": [{
        "paramType": "uri",
        "operator": "match",
        "paramValue": "/**"
    }],
    "ruleDataList": [{
        "ruleHandler": "{\"loadBalance\":\"random\"}",
        "conditionDataList": [{
            "paramType": "uri",
            "operator": "match",
            "paramValue": "/**"
        }]
    }]
}'
```
> If the backend service handling the request is running on your host machine, please set `upstreamUrl` to `host.docker.internal:8080` or specify IP address  if reachable from the container in the above command.
> 
> Add `--network host` to docker run command instead of `--net shenyu` also works correctly.
* Proxy request ：http://localhost:9195/helloworld 

```json
{
  "name" : "Shenyu",
  "data" : "hello world"
}
```
---

# Plugin

 Whenever a request comes in, Apache ShenYu will execute it by all enabled plugins through the chain of responsibility.
 
 As the heart of Apache ShenYu, plugins are extensible and hot-pluggable.
 
 Different plugins do different things.
 
 Of course, users can also customize plugins to meet their own needs.
 
 If you want to customize, see [custom-plugin](https://shenyu.apache.org/docs/developer/custom-plugin/) .
 
---  
 
# Selector & Rule 

  According to your HTTP request headers, selectors and rules are used to route your requests.
  
  Selector is your first route, It is coarser grained, for example, at the module level.
  
  Rule is your second route and what do you think your request should do. For example a method level in a module.
  
  The selector and the rule match only once, and the match is returned. So the coarsest granularity should be sorted last.
 
---  
   
# Data Caching & Data Sync
 
  Since all data have been cached using ConcurrentHashMap in the JVM, it's very fast.
  
  Apache ShenYu dynamically updates the cache by listening to the ZooKeeper node (or WebSocket push, HTTP long polling) when the user changes configuration information in the background management.
  
  ![](https://shenyu.apache.org/img/shenyu/dataSync/shenyu-config-processor-en.png)
  
  ![](https://shenyu.apache.org/img/shenyu/dataSync/config-strategy-processor-en.png)

---    

# Prerequisite
 
   * JDK 17+

---

# Plugin Store Migration Notes

This repository packages Apache ShenYu plugin store modules for gateway-side runtime use.
The migrated SOFA and TARS plugins preserve their ShenYu plugin identifiers, SPI names,
and starter artifact names. Admin registration, client SDKs, and shared DTO contracts remain
supplied by Apache ShenYu itself.

The SOFA and TARS plugin sources were migrated from Apache ShenYu source snapshot
`ec198d442`. This branch builds on apache/shenyu-plugin-store PR #5 (`39f0b767`) and keeps
the store artifact version at `2.7.1-SNAPSHOT` while importing the ShenYu `2.7.0` BOM. The
target gateway line remains Apache ShenYu `2.7.2-SNAPSHOT`. The full store reactor is verified
against the released `2.7.0` API; the migrated SOFA/TARS plugin and starter reactor is also
verified against the current `2.7.2-SNAPSHOT` API. The existing Motan module remains on the
released baseline and cannot use the current API without further compatibility work.

SOFA keeps a store-local selector DTO with the same JSON fields as the main repository's
`SofaUpstream`, because that shared class is absent from the released `2.7.0` API. Protocol
names, orders, and serialized selector handles are retained.

Runtime protocol libraries that were previously declared directly by `shenyu-bootstrap` are
carried by the store starters: SOFA includes `sofa-rpc-all` plus `sofa-common-tools` with the
original bootstrap exclusions, and TARS includes `tars-client:1.7.2`. The plugin runtime
modules keep protocol libraries as compile-time `provided` dependencies; the starters carry
the installable runtime classpath. Add `org.apache.shenyu:shenyu-spring-boot-starter-plugin-sofa`
or `org.apache.shenyu:shenyu-spring-boot-starter-plugin-tars` at the store version to a custom
gateway build after installing or publishing this store reactor.

The original core-only SOFA Docker/Kubernetes test suites are removed from the main reactor.
This migration brings the runtime unit and starter tests to the store; a complete external
starter plus gateway plus backend end-to-end fixture is not included in this change.
   
--- 
        
# Stargazers over time

[![Stargazers over time](https://starchart.cc/apache/shenyu.svg)](https://starchart.cc/apache/shenyu.svg)

---  

# Contributor and Support

* [How to Contribute](https://shenyu.apache.org/community/contributor-guide)
* [Mailing Lists](mailto:dev@shenyu.apache.org)

---  

# Known Users

In order of registration, More access companies are welcome to register at [https://github.com/apache/shenyu/issues/68](https://github.com/apache/shenyu/issues/68) (For open source users only) .

All Users : [Known Users](https://shenyu.apache.org/community/user-registration)
