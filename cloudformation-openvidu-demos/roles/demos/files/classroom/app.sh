#!/bin/bash

exec java -Djava.security.egd=file:/dev/./urandom -Dspring.datasource.url=jdbc:mysql://127.0.0.1/openvidu_sample_app -Dopenvidu.url=https://$1:8443 -Dserver.port=5001 -jar /var/www/html/classroom/classroom-demo.jar

