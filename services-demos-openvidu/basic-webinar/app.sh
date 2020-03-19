#!/bin/bash
exec java -Djava.security.egd=file:/dev/./urandom -Dopenvidu.url=https://$1:4443 -jar /var/www/html/basic-webinar/openvidu-js-java.jar