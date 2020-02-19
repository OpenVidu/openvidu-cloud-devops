#!/bin/bash

if [ "$1" == "nightly" ]; then
	# Ansible openvidu nightly environment
	wget -O /opt/openvidu/openvidu-server.jar http://builds.openvidu.io/openvidu/nightly/latest/openvidu-server-latest.jar
elif [[ "$1" == *"SNAPSHOT"* ]]; then
	# Ansible openvidu snapshot
	wget -O /opt/openvidu/openvidu-server.jar http://builds.openvidu.io/openvidu/snapshots/openvidu-server-$1.jar
else
	# Ansible openvidu production environment
	wget -O /opt/openvidu/openvidu-server.jar https://github.com/OpenVidu/openvidu/releases/download/v$1/openvidu-server-$1.jar
fi
