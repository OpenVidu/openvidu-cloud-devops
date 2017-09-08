#!/bin/bash

INXDB_URL=52.17.94.9
INXDB_DB=ov_demos
INXDB_MEASUREMENT=demo

OV_VERSION="1.0.0-beta.3"
EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
EC2_REGION=$(echo "$EC2_AVAIL_ZONE" | sed 's/[a-z]$//')

curl -i -XPOST "http://$INXDB_URL:8086/write?db=$INXDB_DB" \
  --data-binary "$INXDB_MEASUREMENT,region=$EC2_REGION ov_version=\"$OV_VERSION\" "
