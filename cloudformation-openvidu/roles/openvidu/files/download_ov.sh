#!/bin/bash


wget -O /opt/openvidu/openvidu-server.jar https://github.com/OpenVidu/openvidu/releases/download/v$1/openvidu-server-$1.jar

{% if stage == "prod" %}
# Ansible openvidu producction environment
wget -O /opt/openvidu/openvidu-server.jar https://github.com/OpenVidu/openvidu/releases/download/v$1/openvidu-server-$1.jar
{% else %}
# Ansible openvidu producction environment
wget -O /opt/openvidu/openvidu-server.jar http://builds.openvidu.io/openvidu/nightly/latest/openvidu-server-latest.jar
{% endif %}