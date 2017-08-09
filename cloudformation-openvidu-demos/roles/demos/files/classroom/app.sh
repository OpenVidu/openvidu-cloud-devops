#!/bin/bash

# get MySQL IP
MYSQL_IP=$(docker inspect openvidu-mysql -f '{{ .NetworkSettings.IPAddress }}')

exec java -Djava.security.egd=file:/dev/./urandom -Dspring.datasource.url=jdbc:mysql://${MYSQL_IP}/openvidu_sample_app -Dopenvidu.url=https://$1:8443 -Dserver.port=5001 -jar /var/www/html/classroom/classroom-demo.jar

