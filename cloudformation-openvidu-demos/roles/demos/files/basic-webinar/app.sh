#!/bin/bash
java -Djava.security.egd=file:/dev/./urandom -Dopenvidu.url=https://$1:8443 -jar /var/www/html/basic-webinar/openvidu-js-java.jar

