#!/bin/bash 

sleep 1m

while true
do 
  HTTP_STATUS=$(curl -Ik https://localhost/inspector/ | head -n1 | awk '{print $2}')
  if [ $HTTP_STATUS == 200 ]; then
    break
  fi
  sleep 1
done