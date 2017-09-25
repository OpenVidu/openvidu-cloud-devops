#!/bin/bash

OUTPUT=/opt/workdir/cloudformation-openvidu/roles/openvidu/files/openvidu-server.jar

curl -L -o $OUTPUT https://github.com/OpenVidu/openvidu/releases/download/{{ version }}/openvidu-server-{{ version }}.jar


