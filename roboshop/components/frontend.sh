#!/bin/bash

source components/common.sh


print "installing nginx\t\t"
yum install nginx -y &>>$LOG
Status_Check $?

print "downloading frontend archive"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Status_Check $?

print "Extract frontend archive"
rm -rf /usr/share/nginx/* && cd /usr/share/nginx &&  unzip -o /tmp/frontend.zip && mv frontend-main/* . && mv static html  &>>$LOG
Status_Check $?

print "update nginx Roboshop confg file" 
mv localhost.conf /etc/nginx/default.d/roboshop.conf
Status_Check $?

print "restart nginx\t\t"

systemctl restart nginx && systemctl enable nginx &>>$LOG
Status_Check $?