#!/bin/bas

LID="lt-0a0bf15e726203db3"
LVER=1
Instance_Name=$1



if [ -z "${Instance_Name}" ]; then
echo "Input is missing"
exit 1
fi

Ip=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$Instance_Name}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$Instance_Name}]" | jq .Instances[].PrivateIpAddress) | sed -e 's/"//g'
    