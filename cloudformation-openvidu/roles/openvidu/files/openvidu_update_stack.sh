#!/bin/bash -x
set -e -o pipefail

while [ -f /var/run/openvidu-aftershutdown.lock ]; do
  sleep 1
done

OV_NEW_VERSION=$(cat /var/lib/cloud/instance/scripts/part-001 | grep OPENVIDU_VERSION | cut -d= -f2)

OV_KURENTO_VERSIONS=$(curl --silent https://oudzlg0y3m.execute-api.eu-west-1.amazonaws.com/v1/ov_kms_matrix?ov=${OV_NEW_VERSION})

if [ "${OV_KURENTO_VERSIONS}" == "Not found" ]; then
  echo "ERROR: wrong value for variable ${OV_NEW_VERSION}"
  exit 1
else
  KURENTO_NEW_VERSION=$(jq --raw-output '.[0] | .kms' <<< "${OV_KURENTO_VERSIONS}")
  echo "Updating to OpenVidu ${OV_NEW_VERSION}"
fi

# Stopping openvidu 
supervisorctl stop openvidu-server

# Setting updating in process web page
cd /opt/openvidu/update
python -m SimpleHTTPServer 5443 &
WEB_PID=$!

# Changing source list for Kurento Media Server
echo deb [arch=amd64] http://ubuntu.openvidu.io/${KURENTO_NEW_VERSION} xenial kms6 > /etc/apt/sources.list.d/kurento.list

apt-get update

echo "Removing KMS ..."
apt-get remove --auto-remove --yes kurento-media-server

echo "Installing KMS ${KURENTO_NEW_VERSION} (keeping config files)..."
apt-get install --yes -o Dpkg::Options::="--force-confold" kurento-media-server

systemctl enable kurento-media-server
systemctl start kurento-media-server

# Updating openvidu
wget -O /opt/openvidu/openvidu-server.jar https://github.com/OpenVidu/openvidu/releases/download/v${OV_NEW_VERSION}/openvidu-server-${OV_NEW_VERSION}.jar
supervisorctl start openvidu-server

kill -9 ${WEB_PID}
echo ${OPENVIDU_NEW_VERSION} > /opt/openvidu/version