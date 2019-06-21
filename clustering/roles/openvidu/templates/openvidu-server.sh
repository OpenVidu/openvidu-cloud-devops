#!/bin/bash

# This script will launch OpenVidu Server on your machine

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
OPENVIDU_OPTIONS+="-Dopenvidu.pro.cluster=true "
OPENVIDU_OPTIONS+="-Dopenvidu.pro.cluster.load.strategy={{ OpenviduClusterLoadStrategy }} "

{% if run_ec2 == true %}
export AWS_DEFAULT_REGION={{ aws_default_region }}
KMS_IPs=$(aws ec2 describe-instances --query 'Reservations[].Instances[].[PrivateIpAddress]' --output text --filters Name=instance-state-name,Values=running Name=tag:ov-cluster-member,Values=kms)
KMS_ENDPOINTS=$(for IP in $KMS_IPs
do
  echo $IP | awk '{ print "\"ws://" $1 ":8888/kurento\"" }'
done
)
KMS_ENDPOINTS_LINE=$(echo $KMS_ENDPOINTS | tr ' ' ,)
OPENVIDU_OPTIONS+="-Dkms.uris=[${KMS_ENDPOINTS_LINE}] "
{% endif %}

pushd /opt/openvidu
exec java -jar ${OPENVIDU_OPTIONS} /opt/openvidu/openvidu-server.jar

