#!/bin/bas

LID="lt-0fb3ba0708e861323"
LVER=2
Instance_Name=$1

#if [ -z "${Instance_Name}" ]; then
#echo "Input is missing"
#exit 1
#fi

Ip=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq .Instances[].PrivateIpAddress)

#--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$Instance_Name}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$Instance_Name}]"  | sed -e 's/"//g'
    