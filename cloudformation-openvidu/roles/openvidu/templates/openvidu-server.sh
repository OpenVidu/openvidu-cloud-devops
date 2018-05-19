#!/bin/bash

{% if whichcert == "letsencrypt" or whichcert == "owncert" %}
PUBLIC_HOSTNAME={{ domain_name }}
{% else %}
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
{% endif %}

java -jar -Dopenvidu.secret="{{ openvidusecret }}" -Dopenvidu.recording=true -Dopenvidu.recording.public-access={{ FreeHTTPAccesToRecordingVideos }} -Dserver.ssl.enabled=false -Dopenvidu.publicurl=https://${PUBLIC_HOSTNAME}:{{ openvidu_port }} -Dserver.port=5443 -DMY_UID=$(id -u $USER) /opt/openvidu/openvidu-server.jar

