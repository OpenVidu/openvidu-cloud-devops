#!/bin/bash

# This script will launch OpenVidu Server on your machine

# Wait for kibana
while true
do 
  HTTP_STATUS=$(curl -I http://localhost:5601/app/kibana | head -n1 | awk '{print $2}')
  if [ $HTTP_STATUS == 200 ]; then
    break
  fi
  sleep 1
done

{% if whichcert == "letsencrypt" or whichcert == "owncert" %}
PUBLIC_HOSTNAME={{ domain_name }}
{% else %}
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
{% endif %}

OPENVIDU_OPTIONS="-Dopenvidu.secret={{ openvidusecret }} "
OPENVIDU_OPTIONS+="-Dopenvidu.recording=true "
OPENVIDU_OPTIONS+="-Dopenvidu.recording.public-access={{ FreeHTTPAccesToRecordingVideos }} "
OPENVIDU_OPTIONS+="-Dserver.ssl.enabled=false "
OPENVIDU_OPTIONS+="-Dopenvidu.publicurl=https://${PUBLIC_HOSTNAME}:{{ openvidu_port }} "
OPENVIDU_OPTIONS+="-Dserver.port=5443 "
OPENVIDU_OPTIONS+="-DMY_UID=$(id -u $USER) "
OPENVIDU_OPTIONS+="-Dopenvidu.recording.notification={{ OpenviduRecordingNotification }} "
OPENVIDU_OPTIONS+="-Dopenvidu.streams.video.max-recv-bandwidth={{ OpenviduStreamsVideoMaxRecvBandwidth }} "
OPENVIDU_OPTIONS+="-Dopenvidu.streams.video.min-recv-bandwidth={{ OpenviduStreamsVideoMinRecvBandwidth }} "
OPENVIDU_OPTIONS+="-Dopenvidu.streams.video.max-send-bandwidth={{ OpenviduStreamsVideoMaxSendBandwidth }} "
OPENVIDU_OPTIONS+="-Dopenvidu.streams.video.min-send-bandwidth={{ OpenviduStreamsVideoMinSendBandwidth }} "
OPENVIDU_OPTIONS+="-Dopenvidu.pro.kibana.host=http://localhost/kibana "
OPENVIDU_OPTIONS+="-Dopenvidu.recording.composed-url=https://${PUBLIC_HOSTNAME}/inspector/ "

pushd /opt/openvidu
exec java -jar ${OPENVIDU_OPTIONS} openvidu-server.jar

