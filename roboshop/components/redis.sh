#!/bin/bash

source components/common.sh

print "install yum utils and download redis repos"

yum install epel-release yum-utils -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>LOG
Status_Check $?

print "setting up redis repos\t\t\t"
yum-config-manager --enable remi &>>$LOG
Status_Check $?

print "install redis repos\t\t\t"
yum install redis -y &>>$LOG
Status_Check $?

print "configure redis ip adress\t\t"
if [ -f /etc/redis.conf ]; then
sed -i -e  's/127.0.0.1/0.0.0.0/'  /etc/redis.conf 
fi

if [ -f /etc/redis/redis.conf ]; then
sed -i -e  's/127.0.0.1/0.0.0.0/'  /etc/redis/redis.conf
fi
Status_Check $?

print "starting database\t\t\t"
systemctl enable redis &>>$LOG && systemctl restart redis &>>$LOG
Status_Check $?