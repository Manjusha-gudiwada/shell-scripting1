#!/bin/bash

source components/common.sh

print "installing Erlang\t"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y  &>>$LOG
Status_Check $?
print "Setup rabbitmq repo\t"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG
Status_Check $?

print "Install RabbitMQ\t"
yum install rabbitmq-server -y &>>$LOG
Status_Check $?

print "Start RabbitMQ\t\t"
systemctl enable rabbitmq-server &>>$LOG && systemctl start rabbitmq-server &>>$LOG
Status_Check $?

print "Create application user\t"
rabbitmqctl add_user roboshop roboshop123 &>>$LOG && rabbitmqctl set_user_tags roboshop administrator &>>$LOG && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG
Status_Check $?