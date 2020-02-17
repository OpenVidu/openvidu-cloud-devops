#!/bin/bash

OV_VERSION={{ openvidu_version }}
KMS_VERSION=6.13.0
echo "deb [arch=amd64] http://ubuntu.openvidu.io/${KMS_VERSION} xenial kms6" > /etc/apt/sources.list.d/kurento.list
apt-get update
