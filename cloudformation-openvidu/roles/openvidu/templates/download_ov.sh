#!/bin/bash

OUTPUT=/opt/workdir/cloudformation-openvidu/roles/openvidu/files/openvidu-server.jar

{% if version == "latest" %}
RELEASE_URL=https://api.github.com/repos/openvidu/openvidu/releases/latest
DOWNLOAD_URL=$(curl -s $RELEASE_URL | grep browser_download_url | cut -d '"' -f 4 | grep openvidu-server)
curl -L -o $OUTPUT $DOWNLOAD_URL
{% else %}
curl -L -o $OUTPUT https://github.com/OpenVidu/openvidu/releases/download/v{{ version }}/openvidu-server-{{ version }}.jar
{% endif %}

