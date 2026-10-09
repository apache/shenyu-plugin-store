#!/usr/bin/env perl
#
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

use strict;
use warnings;
use IO::Socket::INET;
use POSIX ':sys_wait_h';
use Errno qw(EINTR);

my $port = $ENV{'STORE_BACKEND_PORT'} || 9080;
my $fallback_delay = $ENV{'STORE_BACKEND_FALLBACK_DELAY_SECONDS'} || 4;

my $server = IO::Socket::INET->new(
    LocalAddr => '0.0.0.0',
    LocalPort => $port,
    Proto => 'tcp',
    Listen => 50,
    Reuse => 1,
) or die "Cannot start plugin store backend on port $port: $!\n";

$SIG{CHLD} = sub {
    while (waitpid(-1, WNOHANG) > 0) {
    }
};

print "plugin store backend listening on $port\n";

while (1) {
    my $client = $server->accept();
    if (!$client) {
        next if $! == EINTR;
        warn "accept failed: $!\n";
        next;
    }
    my $pid = fork();
    if (!defined $pid) {
        close $client;
        next;
    }
    if ($pid == 0) {
        close $server;
        handle_client($client);
        close $client;
        exit 0;
    }
    close $client;
}

sub handle_client {
    my ($client) = @_;
    my $request_line = <$client> || '';
    my ($method, $target) = $request_line =~ m{^(\S+)\s+(\S+)\s+HTTP/};
    while (my $line = <$client>) {
        last if $line =~ /^\r?$/;
    }

    my $path = defined $target ? $target : '/';
    $path =~ s/\?.*//;

    if ($method && $method eq 'GET' && $path eq '/http/test/hystrix/fallback') {
        sleep $fallback_delay;
        respond($client, 200, '{"code":200,"msg":"slow success","data":"hystrix-slow"}');
        return;
    }

    if ($method && $method eq 'GET' && $path eq '/http/test/hystrix/pass') {
        respond($client, 200, '{"code":200,"msg":"success","data":"hystrix-pass"}');
        return;
    }

    if ($method && $method eq 'GET' && $path eq '/http/order/findById') {
        respond($client, 200, '{"id":"order-found","status":"success"}');
        return;
    }

    if ($method && $method eq 'GET' && $path eq '/actuator/health') {
        respond($client, 200, '{"status":"UP"}');
        return;
    }

    respond($client, 404, '{"code":404,"msg":"not found"}');
}

sub respond {
    my ($client, $status, $body) = @_;
    my $reason = $status == 200 ? 'OK' : 'Not Found';
    my $length = length($body);
    print $client "HTTP/1.1 $status $reason\r\n";
    print $client "Content-Type: application/json\r\n";
    print $client "Content-Length: $length\r\n";
    print $client "Connection: close\r\n";
    print $client "\r\n";
    print $client $body;
}
