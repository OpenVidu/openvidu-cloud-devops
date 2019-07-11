#!/bin/bash -xe

sudo apt-get update

# install coturn
apt-get install -y coturn

# install kms
sudo apt-get update
sudo echo "deb [arch=amd64] http://ubuntu.openvidu.io/6.10.0 xenial kms6" >/etc/apt/sources.list.d/kurento.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5AFA7A83
sudo apt-get update 
sudo apt-get install -y kurento-media-server
systemctl enable kurento-media-server

