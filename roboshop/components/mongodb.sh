#!/bin/bash

source components/common.sh

print "settingup mongodb"

echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo

Status_Check $?

print "installing mongodb"
 yum install -y mongodb-org &>>/tmp/log
 
Status_Check $?
 
 print "configuring mongodb"
 
 sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
 
 Status_Check $?
 
print "starting mongodb"
systemctl enable mongod
systemctl restart mongod

Status_Check $?

print "Downloading schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

Status_Check $?

cd /tmp
print "extracting scheme"
unzip -o mongodb.zip &>>/tmp/log

Status_Check $?

cd mongodb-main
print "loading schema \t"
mongo < catalogue.js &>>/tmp/log
mongo < users.js  &>>/tmp/log

Status_Check $?

exit 0