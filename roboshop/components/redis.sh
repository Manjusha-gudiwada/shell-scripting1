#!/bin/bash

source components/common.sh

print "install yum utils and download redis repos"

yum install epel-release yum-utils -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>LOG
Status_Check $?

print "setting up redis repos"
yum-config-manager --enable remi &>>$LOG
Status_Check $?

print "install redis repos"
yum install redis -y &>>$LOG
Status_Check $?

print "configure redis ip adress"
sed -i -e  's/127.0.0.1/0.0.0.0/'  /etc/redis.conf 
Status_Check $?

print "starting database"
Start Redis Database
systemctl enable redis &>>$LOG && systemctl start redis &>>$LOG
Status_Check $?