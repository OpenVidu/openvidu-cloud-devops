#!/bin/bash

PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

java -jar -Dopenvidu.secret="{{ openvidusecret }}" Dopenvidu.recording=true -Dopenvidu.recording.free-access={{ FreeHTTPAccesToRecordingVideos }} -Dserver.ssl.enabled=false -Dopenvidu.publicurl=https://${PUBLIC_HOSTNAME}:8443 -Dserver.port=5443 /opt/openvidu/openvidu-server.jar


