#!/bin/bas

LID="lt-0fb3ba0708e861323"
LVER=2

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER