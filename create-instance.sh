#!/bin/bas

LID="lt-0a0bf15e726203db3"
LVER=1
Instance_Name=$1



if [ -z "${Instance_Name}" ]; then
echo "Input is missing"
exit 1
fi

aws ec2 describe-instances --filters "Name=tag:Name,Values=$Instance_Name" | jq .Reservations[].Instances[].State.Name | grep running &>/dev/null

if [ $? -eq 0 ]; then
echo "Instance $Instance_Name is already running"
exit 0
fi

aws ec2 describe-instances --filters "Name=tag:Name,Values=$Instance_Name" | jq .Reservations[].Instances[].State.Name | grep stopped &>/dev/null

if [ $? -eq 0 ]; then
echo "Instance $Instance_Name is already created & stopped"
exit 0
fi

Ip=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$Instance_Name}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$Instance_Name}]" | jq .Instances[].PrivateIpAddress) | sed -e 's/"//g'
    