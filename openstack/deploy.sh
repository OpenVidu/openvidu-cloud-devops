#!/bin/bash -xe
source /home/ubuntu/.bashrc
export HOME=/home/ubuntu
apt-get update
apt-get install -y git software-properties-common python-pip
apt-add-repository -y ppa:ansible/ansible
apt-get update && sudo apt-get install -y ansible

git clone https://github.com/OpenVidu/openvidu-cloud-devops /opt/workdir
pushd /opt/workdir/cloudformation-openvidu-demos
git checkout 2.2.0
WORKINGDIR=/opt/workdir/cloudformation-openvidu-demos
PIP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
PublicHostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
ansible-galaxy install geerlingguy.mysql
OPENVIDU_VERSION=2.2.0
OPENVIDU_DEMOS_VERSION=2.0.0
DOMAIN_NAME=demos.openvidu.io

# nginx
sed -i "s/DOMAIN_NAME/demos.openvidu.io/" $WORKINGDIR/roles/nginx/vars/main.yml
sed -i "s/LETSENCRYPT_EMAIL/openvidu@gmail.com/" $WORKINGDIR/roles/nginx/vars/main.yml
sed -i "s/AWS_EIP/$PIP/" $WORKINGDIR/roles/nginx/vars/main.yml
sed -i "s/AWS_PUBLIC_HOSTNAME/$PublicHostname/" $WORKINGDIR/roles/nginx/vars/main.yml
sed -i "s/whichcert: selfsigned/whichcert: letsencrypt/" $WORKINGDIR/roles/nginx/vars/main.yml

# OpenVidu
sed -i "s/OV_VERSION/$OPENVIDU_VERSION/" $WORKINGDIR/roles/openvidu/vars/main.yml
sed -i "s/DEMOS_RELEASE/$OPENVIDU_DEMOS_VERSION/" $WORKINGDIR/roles/openvidu/vars/main.yml
sed -i "s/DOMAIN_NAME//" $WORKINGDIR/roles/openvidu/vars/main.yml
sed -i "s/whichcert: selfsigned/whichcert: letsencrypt/" $WORKINGDIR/roles/openvidu/vars/main.yml

# supervisor
sed -i "s/AWS_PUBLIC_HOSTNAME/$PublicHostname/" $WORKINGDIR/roles/supervisord/vars/main.yml
sed -i "s/AWS_EIP/$PIP/" $WORKINGDIR/roles/supervisord/vars/main.yml
sed -i "s/whichcert: selfsigned/whichcert: letsencrypt/" $WORKINGDIR/roles/supervisord/vars/main.yml
sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/" $WORKINGDIR/roles/supervisord/vars/main.yml
sed -i "s/TURN_PASSWORD/s3cr3t0/" $WORKINGDIR/roles/kms/vars/main.yml

# KMS
sed -i "s/TURN_USER/turn_user/" $WORKINGDIR/roles/kms/vars/main.yml
sed -i "s/AWS_EIP/$PIP/" $WORKINGDIR/roles/kms/vars/main.yml

# stats
sed -i "s/allowsendinfo: true/allowsendinfo: false/" $WORKINGDIR/roles/stats/vars/main.yml

ansible-playbook -i "localhost," -c local play.yml
popd

