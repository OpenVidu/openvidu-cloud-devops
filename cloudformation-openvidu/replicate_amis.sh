#!/bin/bash
set -eu -o pipefail

# Replicate AMIs in all regions
#
# Input parameters:
#
# OV_AMI_NAME   OpenVidu AMI Name
# OV_AMI_ID     OpenVidu AMI ID

export AWS_DEFAULT_REGION=eu-west-1
if [ ${CF_OVP_TARGET} == "market" ]; then
    export AWS_ACCESS_KEY_ID=${NAEVA_AWS_ACCESS_KEY_ID}
    export AWS_SECRET_ACCESS_KEY=${NAEVA_AWS_SECRET_ACCESS_KEY}
fi

echo "Making original AMI public"
aws ec2 modify-image-attribute --image-id ${OV_AMI_ID} --launch-permission "Add=[{Group=all}]"

TARGET_REGIONS="eu-north-1
                eu-west-3
                eu-west-2
                eu-west-1
                ap-northeast-2
                ap-northeast-1
                sa-east-1
                ca-central-1
                ap-south-1
                ap-southeast-1
                ap-southeast-2
                ap-northeast-1
                ap-northeast-2
                ap-east-1
                eu-central-1
                us-east-1
                us-east-2
                us-west-1
                us-west-2
                me-south-1"

echo "OV IDs"
for REGION in ${TARGET_REGIONS}
do
    ID=$(aws ec2 copy-image --name ${OV_AMI_NAME} --source-image-id ${OV_AMI_ID} --source-region ${AWS_DEFAULT_REGION} --region ${REGION} --output text --query 'ImageId')
    aws ec2 modify-image-attribute --image-id ${ID} --launch-permission "Add=[{Group=all}]"
    echo "    ${REGION}:"
    echo "      AMI: ${ID}"
done