#!/bin/bash -xe

apt-add-repository -y ppa:ansible/ansible
apt-get update && apt-get install -y ansible jq
ansible-galaxy install -p /etc/ansible/roles geerlingguy.docker
ansible-galaxy install -p /etc/ansible/roles geerlingguy.mysql

git clone https://github.com/OpenVidu/openvidu-cloud-devops /usr/src/openvidu
cd /usr/src/openvidu/cloudformation-openvidu
git checkout azure

PIP=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text")
PublicHostname=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-04-02" | jq --raw-output '.compute | .name + "." + .location + ".cloudapp.azure.com"')
sed -i "s/AWS_EIP/$PIP/" group_vars/all
sed -i "s/AWS_PUBLIC_HOSTNAME/$PublicHostname/" group_vars/all

# wait for parameters file
while true
do
    if [ -f /opt/openvidu/parameters.sh ]; then
        break
    else
        sleep 1
    fi
done

. /opt/openvidu/parameters.sh


sed -i "s/OPENVIDU_VERSION/${OPENVIDU_VERSION}/" group_vars/all
sed -i "s/DEMOS_VERSION/${OPENVIDU_DEMOS_VERSION}/" group_vars/all
sed -i "s/OVC_VERSION/${OPENVIDU_CALL_VERSION}/" group_vars/all
sed -i "s/WANTDEMOS/${WANT_TO_DEPLOY_DEMOS}/" group_vars/all
sed -i "s/selfsigned/${WHICH_CERT}/" group_vars/all
sed -i "s/DOMAIN_NAME/${MY_DOMAIN_NAME}/" group_vars/all
sed -i "s/LETSENCRYPT_EMAIL/${LETS_ENCRYPT_EMAIL}/" group_vars/all
sed -i "s/MY_SECRET/${OPENVIDU_SECRET}/" group_vars/all
sed -i "s/run_ec2: false/run_ec2: false/" group_vars/all
sed -i "s/allowsendinfo: true/allowsendinfo: ${WANT_SEND_INFO}/" group_vars/all             
sed -i "s/FREEHTTPACCESTORECORDINGVIDEOS/${FREE_HTTP_ACCESS_TO_RECORDING_VIDEOS}/" group_vars/all
sed -i "s/OPENVIDURECORDINGNOTIFICATION/${OPENVIDU_RECORDING_NOTIFICATION}/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMAX-RECV-BANDWIDTH/${OPENVIDU_STREAMS_VIDEO_MAX_RECV_BANDWIDTH}/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMIN-RECV-BANDWIDTH/${OPENVIDU_STREAMS_VIDEO_MIN_RECV_BANDWIDTH}/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMAX-SEND-BANDWIDTH/${OPENVIDU_STREAMS_VIDEO_MAX_SEND_BANDWIDTH}/" group_vars/all
sed -i "s/OPENVIDUSTREAMSVIDEOMIN-SEND-BANDWIDTH/${OPENVIDU_STREAMS_VIDEO_MIN_SEND_BANDWIDTH}/" group_vars/all
sed -i "s/WEBHOOK_ENABLED/${OPENVIDU_WEBHOOK}/" group_vars/all
sed -i "s#WEBHOOK_ENDPOINT#${OPENVIDU_WEBHOOK_ENDPOINT}#" group_vars/all
sed -i "s/WEBHOOK_HEADERS/${OPENVIDU_WEBHOOK_HEADERS}/" group_vars/all
sed -i "s/WEBHOOK_EVENTS/${OPENVIDU_WEBHOOK_EVENTS}/" group_vars/all

export HOME=/home/ubuntu

ansible-playbook -i "localhost," -c local play.yml

# Wait for the app
#/usr/local/bin/check_app_ready.sh