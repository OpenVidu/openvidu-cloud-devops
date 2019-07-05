#!/bin/bash

# This script will launch OpenVidu Server on your machine

OV_PROPERTIES="/opt/openvidu/application.properties"

{% if whichcert == "letsencrypt" or whichcert == "owncert" %}
PUBLIC_HOSTNAME={{ domain_name }}
{% else %}
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
{% endif %}

sed -i "s#openvidu.publicurl=.*#openvidu.publicurl=https://${PUBLIC_HOSTNAME}:{{ openvidu_port }}#" ${OV_PROPERTIES}
sed -i "s/MY_UID=.*/MY_UID=$(id -u $USER)/" ${OV_PROPERTIES}
sed -i "s#openvidu.recording.composed-url=.*#openvidu.recording.composed-url=https://${PUBLIC_HOSTNAME}/inspector/#" ${OV_PROPERTIES}

EVENTS_LIST=$(echo {{ webhook_events }} | tr , ' ')
if [ "x$EVENTS_LIST" != "x" ]; then
	E=$(for EVENT in ${EVENTS_LIST}
	do
		echo $EVENT | awk '{ print "\"" $1 "\"" }'
	done
	)
	EVENTS=$(echo $E | tr ' ' ,)
	if ! grep -Fq "openvidu.webhook.events" ${OV_PROPERTIES}
	then
		echo "openvidu.webhook.events=[${EVENTS}]" >> ${OV_PROPERTIES}
	fi
fi

HEADERS="{{ webhook_headers }}"
if [ "x${HEADERS}" != "x" ]; then
	OPENVIDU_HEADERS="[\"${HEADERS}\"]"
	if ! grep -Fq "openvidu.webhook.headers" ${OV_PROPERTIES}
	then
		echo "openvidu.webhook.headers=${OPENVIDU_HEADERS}" >> ${OV_PROPERTIES}
	fi
fi

pushd /opt/openvidu/
exec java -jar -Dspring.config.additional-location=${OV_PROPERTIES} openvidu-server.jar

