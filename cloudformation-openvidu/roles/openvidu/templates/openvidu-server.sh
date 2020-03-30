#!/bin/bash

# This script will launch OpenVidu Server on your machine

OV_PROPERTIES="/opt/openvidu/application.properties"

PUBLIC_HOSTNAME={{ domain_name }}

sed -i "s#openvidu.publicurl=.*#openvidu.publicurl=https://${PUBLIC_HOSTNAME}:{{ openvidu_server_port }}#" ${OV_PROPERTIES}
sed -i "s/MY_UID=.*/MY_UID=$(id -u $USER)/" ${OV_PROPERTIES}

EVENTS_LIST=$(echo {{ openvidu_webhook_events }} | tr , ' ')
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

HEADERS="{{ openvidu_webhook_headers }}"
if [ "x${HEADERS}" != "x" ]; then
	OPENVIDU_HEADERS="[\"${HEADERS}\"]"
	if ! grep -Fq "openvidu.webhook.headers" ${OV_PROPERTIES}
	then
		echo "openvidu.webhook.headers=${OPENVIDU_HEADERS}" >> ${OV_PROPERTIES}
	fi
fi

pushd /opt/openvidu/
exec java -jar -Dspring.config.additional-location=${OV_PROPERTIES} openvidu-server.jar

