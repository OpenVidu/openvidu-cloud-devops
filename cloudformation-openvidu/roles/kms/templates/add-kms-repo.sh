#!/bin/bash

OV_VERSION={{ openvidu_version }}
KMS_VERSION=$(curl --silent https://oudzlg0y3m.execute-api.eu-west-1.amazonaws.com/v1/ov_kms_matrix?ov=${OV_VERSION} | jq --raw-output '.[0] | .kms' )
echo "deb [arch=amd64] http://ubuntu.openvidu.io/${KMS_VERSION} {{ codename }} kms6" > /etc/apt/sources.list.d/kurento.list
apt-get update
