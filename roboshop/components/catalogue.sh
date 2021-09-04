#!/bin/bash

source components/common.sh

print "Installing nodejs"

yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?



print "adding roboshop user"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
echo "user exists so skipping this step" &>>$LOG

else
useradd roboshop &>>$LOG
fi
Status_Check $?

print "downloading catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_Check $?

print "Extracting catalogue"
cd /home/roboshop
# in order to avoid many times unzip of file we are removing content inside it before running
rm -rf catalogue && unzip /tmp/catalogue.zip &>>$LOG && mv catalogue-main catalogue
Status_Check $?

print "downloading nodejs dependencies"
cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$LOG # this is written becoz we have to switch to user and install
Status_Check $?

chown roboshop:roboshop -R /home/roboshop

print "update systemd service"

sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service
Status_Check $?

print "setup systemD service file"

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service && systemctl daemon-reload && systemctl restart catalogue &>>$LOG && systemctl enable catalogue &>>$LOG
Status_Check $?