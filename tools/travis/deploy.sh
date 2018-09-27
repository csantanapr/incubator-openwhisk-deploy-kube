#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more contributor
# license agreements; and to You under the Apache License, Version 2.0.

set -x

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../../"

cd $ROOTDIR

echo "Publishing kube-invoker-agent image"
./tools/travis/publish.sh openwhisk kube-invoker-agent latest docker/invoker-agent

echo "Publishing create-docker-network image"
./tools/travis/publish.sh openwhisk create-docker-network latest docker/create-docker-network
