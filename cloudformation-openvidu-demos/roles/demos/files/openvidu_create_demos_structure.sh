#!/bin/bash -x
set -eu -o pipefail

# Vars
OV_RELEASE=$1
DEMOS_RELEASE=$2
CF_RELEASE=master
WORKDIR=$(mktemp -d --suffix .ov)
TARGETDIR=/var/www/html

## Common tasks
# clone the repos
cd $WORKDIR
git clone https://github.com/OpenVidu/openvidu-tutorials.git
cd openvidu-tutorials
git checkout v$DEMOS_RELEASE
cd ..

# Basic Videoconference (openvidu-insecure-js)
mkdir -p $TARGETDIR/basic-videoconference
cp -rav $WORKDIR/openvidu-tutorials/openvidu-insecure-js/web/* $TARGETDIR/basic-videoconference
wget https://github.com/OpenVidu/openvidu/releases/download/v${OV_RELEASE}/openvidu-browser-${OV_RELEASE}.js -O $TARGETDIR/basic-videoconference/openvidu-browser-${OV_RELEASE}.js

# Basic Webinar (openvidu-js-java)
mkdir -p $TARGETDIR/basic-webinar
wget https://github.com/OpenVidu/openvidu-tutorials/releases/download/v${DEMOS_RELEASE}/openvidu-js-java-${DEMOS_RELEASE}.jar -O $TARGETDIR/basic-webinar/openvidu-js-java.jar

# Getaroom
mkdir -p $TARGETDIR/getaroom 
cp -rav $WORKDIR/openvidu-tutorials/openvidu-getaroom/web/* $TARGETDIR/getaroom
wget https://github.com/OpenVidu/openvidu/releases/download/v${OV_RELEASE}/openvidu-browser-${OV_RELEASE}.js -O $TARGETDIR/getaroom/openvidu-browser-${OV_RELEASE}.js

# Openvidu Classroom
mkdir -p $TARGETDIR/classroom
wget https://github.com/OpenVidu/classroom-demo/releases/download/v${DEMOS_RELEASE}/classroom-demo-${DEMOS_RELEASE}.war -O $TARGETDIR/classroom/classroom-demo.jar

# Openvidu Call
mkdir -p $TARGETDIR/openvidu-call
tar zxf /home/ubuntu/openvidu-call.tar.gz -C $TARGETDIR/openvidu-call

# Web Page
git clone https://github.com/OpenVidu/openvidu-cloud-devops
cd openvidu-cloud-devops
git checkout $CF_RELEASE
cp -rav web-demos-openvidu/* $TARGETDIR/

# Cleaning the house
rm -rf $WORKDIR
