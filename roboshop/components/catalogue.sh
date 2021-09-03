#!/bin/bash

source components/common.sh

print "Installing nodejs"

yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

print "adding roboshop user"

useradd roboshop &>>$LOG
Status_Check $?

print "downloading catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_Check $?

print "Extracting catalogue"
cd /home/roboshop
unzip /tmp/catalogue.zip &>>$LOG
mv catalogue-main catalogue
Status_Check $?

cd /home/roboshop/catalogue
npm install 

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue