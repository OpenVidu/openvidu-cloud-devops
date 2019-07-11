#!/bin/bash -xe

apt-add-repository -y ppa:ansible/ansible
apt-get update && apt-get install -y ansible
ansible-galaxy install -p /etc/ansible/roles geerlingguy.docker
ansible-galaxy install -p /etc/ansible/roles geerlingguy.mysql

git clone https://github.com/OpenVidu/openvidu-cloud-devops /usr/src/openvidu
cd /usr/src/openvidu/cloudformation-openvidu
git checkout azure

PIP=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text")
PublicHostname="openvidu.westeurope.cloudapp.azure.com"
sed -i "s/AWS_EIP/$PIP/" group_vars/all
sed -i "s/AWS_PUBLIC_HOSTNAME/$PublicHostname/" group_vars/all

OPENVIDU_VERSION=2.10.0
OPENVIDU_DEMOS_VERSION=2.10.0
OPENVIDU_CALL_VERSION=2.10.0
sed -i "s/OPENVIDU_VERSION/$OPENVIDU_VERSION/" group_vars/all
sed -i "s/DEMOS_VERSION/$OPENVIDU_DEMOS_VERSION/" group_vars/all
sed -i "s/OVC_VERSION/$OPENVIDU_CALL_VERSION/" group_vars/all
sed -i "s/WANTDEMOS/false/" group_vars/all
sed -i "s/selfsigned/selfsigned/" group_vars/all
sed -i "s/DOMAIN_NAME/${MyDomainName}/" group_vars/all
sed -i "s/LETSENCRYPT_EMAIL/${LetsEncryptEmail}/" group_vars/all
sed -i "s/MY_SECRET/MY_SECRET/" group_vars/all
sed -i "s/run_ec2: false/run_ec2: false/" group_vars/all
sed -i "s/allowsendinfo: true/allowsendinfo: false/" group_vars/all             
sed -i "s/FREEHTTPACCESTORECORDINGVIDEOS/false/" group_vars/all
sed -i "s/OPENVIDURECORDINGNOTIFICATION/publisher_moderator/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMAX-RECV-BANDWIDTH/0/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMIN-RECV-BANDWIDTH/0/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMAX-SEND-BANDWIDTH/0/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMIN-SEND-BANDWIDTH/0/" group_vars/all
sed -i "s/WEBHOOK_ENABLED/false/" group_vars/all
sed -i "s#WEBHOOK_ENDPOINT#123#" group_vars/all
sed -i "s/WEBHOOK_HEADERS/123/" group_vars/all
sed -i "s/WEBHOOK_EVENTS/123/" group_vars/all

source /home/ubuntu/.bashrc
export HOME=/home/ubuntu

pushd /usr/src/openvidu/cloudformation-openvidu
ansible-playbook -i "localhost," -c local play.yml
popd

# Wait for the app
/usr/local/bin/check_app_ready.sh