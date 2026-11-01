# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$CoreCheckout,
    [string]$DependencyCache
)

$ErrorActionPreference = 'Stop'
$coreCheckoutRoot = [System.IO.Path]::GetFullPath($CoreCheckout)
$storeRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$wrapper = Join-Path $coreCheckoutRoot 'mvnw.cmd'
if (-not (Test-Path -LiteralPath $wrapper -PathType Leaf)) {
    throw 'CoreCheckout must contain the repository Maven wrapper'
}
$corePom = [xml](Get-Content -LiteralPath (Join-Path $coreCheckoutRoot 'pom.xml'))
$coreVersion = [string]$corePom.project.version
if ($coreVersion -ne '2.7.2-SNAPSHOT') {
    throw 'This example pins core 2.7.2-SNAPSHOT; use its recorded source revision'
}
if ([string]::IsNullOrWhiteSpace($DependencyCache)) {
    $settingsFile = Join-Path $env:USERPROFILE '.m2/settings.xml'
    if (Test-Path -LiteralPath $settingsFile) {
        $settings = [xml](Get-Content -LiteralPath $settingsFile)
        $DependencyCache = [string]$settings.settings.localRepository
    }
    if ([string]::IsNullOrWhiteSpace($DependencyCache)) {
        $DependencyCache = Join-Path $env:USERPROFILE '.m2/repository'
    }
}
$dependencyRoot = [System.IO.Path]::GetFullPath($DependencyCache)
$proofRoot = Join-Path $storeRoot 'target/legacy-contract-proof'
$stagingRoot = Join-Path $proofRoot 'staging-repository'
$consumerRepository = Join-Path $proofRoot ('consumer-repository-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $proofRoot, $stagingRoot, $consumerRepository | Out-Null
$originalBaseDir = $env:MAVEN_BASEDIR
$env:MAVEN_BASEDIR = $coreCheckoutRoot

function Invoke-ContractMaven {
    param([string]$Directory, [string[]]$Arguments, [string]$Log)
    Push-Location -LiteralPath $Directory
    try {
        & $wrapper @Arguments *> $Log
        $result = $LASTEXITCODE
    } finally {
        Pop-Location
    }
    if ($result -ne 0) {
        Get-Content -LiteralPath $Log -Tail 35
        throw "Maven verification failed; see $Log"
    }
}

$hashes = [System.Collections.Generic.List[object]]::new()
function Copy-StagedModule {
    param([string]$Checkout, [string]$Module, [string]$Version)
    $moduleRoot = if ($Module) { Join-Path $Checkout $Module } else { $Checkout }
    $pomFile = Join-Path $moduleRoot 'pom.xml'
    $model = [xml](Get-Content -LiteralPath $pomFile)
    $artifact = [string]$model.project.artifactId
    $destination = Join-Path $stagingRoot "org/apache/shenyu/$artifact/$Version"
    New-Item -ItemType Directory -Force -Path $destination | Out-Null
    Copy-Item -LiteralPath $pomFile -Destination (Join-Path $destination "$artifact-$Version.pom") -Force
    $metadata = Join-Path $dependencyRoot "org/apache/shenyu/$artifact/$Version/maven-metadata-local.xml"
    if (-not (Test-Path -LiteralPath $metadata)) {
        throw "Missing producer install metadata for $artifact"
    }
    Copy-Item -LiteralPath $metadata -Destination (Join-Path $destination 'maven-metadata.xml') -Force
    if ([string]$model.project.packaging -ne 'pom') {
        $jarName = "$artifact-$Version.jar"
        $jar = Join-Path $moduleRoot "target/$jarName"
        $stagedJar = Join-Path $destination $jarName
        Copy-Item -LiteralPath $jar -Destination $stagedJar -Force
        $hashes.Add([pscustomobject]@{
            artifact = $artifact; version = $Version; sha256 = (Get-FileHash -LiteralPath $stagedJar -Algorithm SHA256).Hash
        })
    }
}

try {
    Invoke-ContractMaven $coreCheckoutRoot @('-B', '-ntp', '-pl', 'shenyu-web', '-am', 'install',
        '-DskipTests', '-Djacoco.skip=true', '-DskipRemoteResources=true', '-Dmaven.javadoc.skip=true') (Join-Path $proofRoot 'core-producer.log')
    Invoke-ContractMaven $storeRoot @('-B', '-ntp', '-f', 'pom.xml', '-pl', 'shenyu-plugin/shenyu-plugin-store-test-support', '-am', 'install',
        '-Dtest=LegacyPluginContractKitTest,ShenyuGatewayTestServerTest', '-Dsurefire.failIfNoSpecifiedTests=false',
        '-Djacoco.skip=true', '-DskipRemoteResources=true', '-Dmaven.javadoc.skip=true') (Join-Path $proofRoot 'kit-producer.log')
    foreach ($module in @('', 'shenyu-register-center', 'shenyu-register-center/shenyu-register-protocol', 'shenyu-common', 'shenyu-spi',
        'shenyu-sync-data-center', 'shenyu-sync-data-center/shenyu-sync-data-api', 'shenyu-plugin', 'shenyu-plugin/shenyu-plugin-api',
        'shenyu-loadbalancer', 'shenyu-plugin/shenyu-plugin-base', 'shenyu-web')) {
        Copy-StagedModule $coreCheckoutRoot $module $coreVersion
    }
    foreach ($module in @('', 'shenyu-plugin', 'shenyu-plugin/shenyu-plugin-store-test-support')) {
        Copy-StagedModule $storeRoot $module '2.7.1-SNAPSHOT'
    }
    $stagingUri = ([uri]($stagingRoot + [System.IO.Path]::DirectorySeparatorChar)).AbsoluteUri
    $dependencyUri = ([uri]($dependencyRoot + [System.IO.Path]::DirectorySeparatorChar)).AbsoluteUri
    $coreRevision = (& git -C $coreCheckoutRoot rev-parse HEAD).Trim()
    $consumerRoot = Join-Path $storeRoot 'contract-examples/legacy-plugin-consumer'
    # A fresh local repository prevents preinstalled ShenYu snapshots from satisfying the consumer.
    # The fallback file repository permits releases only, never the staged ShenYu snapshots.
    Invoke-ContractMaven $consumerRoot @('-B', '-ntp', '-f', 'pom.xml', 'clean', 'test',
        "-Dmaven.repo.local=$consumerRepository", "-Dcontract.stagingRepository=$stagingUri", "-Dcontract.dependencyCache=$dependencyUri",
        "-Dcontract.coreRevision=$coreRevision", '-Dcontract.smoke=true') (Join-Path $proofRoot 'external-consumer.log')
    foreach ($entry in $hashes) {
        $resolved = Join-Path $consumerRepository "org/apache/shenyu/$($entry.artifact)/$($entry.version)/$($entry.artifact)-$($entry.version).jar"
        if ((Get-FileHash -LiteralPath $resolved -Algorithm SHA256).Hash -ne $entry.sha256) {
            throw "Consumer did not use the staged bytes for $($entry.artifact)"
        }
    }
    [pscustomobject]@{
        coreRevision = $coreRevision; coreVersion = $coreVersion
        kitRevision = (& git -C $storeRoot rev-parse HEAD).Trim()
        kitWorkingTree = (& git -C $storeRoot status --porcelain)
        stagingRepository = $stagingRoot; isolatedConsumerRepository = $consumerRepository
        artifacts = $hashes
    } | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $proofRoot 'proof.json') -Encoding utf8
    Get-Content -LiteralPath (Join-Path $proofRoot 'external-consumer.log') -Tail 18
    Write-Output ("Verified staged artifact hashes; proof: " + (Join-Path $proofRoot 'proof.json'))
} finally {
    $env:MAVEN_BASEDIR = $originalBaseDir
}
