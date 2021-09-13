#!/bin/bash

source components/common.sh


print "setup mysql\t\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Status_Check $?

print "Install MySQL\t\t"
yum remove mariadb-libs -y &>>$LOG && yum install mysql-community-server -y &>>$LOG
Status_Check $?

print "Start MySQL\t\t"
systemctl enable mysqld &>>$LOG &&  systemctl start mysqld &>>$LOG
Status_Check $?


DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')

 print "changing default password\t"
echo 'show databases' | mysql -uroot -pRoboShop@1 &>>$LOG

if [ $? -eq 0 ]; then
    echo "root pssword is already set" &>>$LOG
else
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" >/tmp/reset.sql
  mysql --connect-expired-password -u root -p"${DEFAULT_PASSWORD}" </tmp/reset.sql &>>$LOG
fi
Status_Check $?


print "uninstall password validate_plugin"

echo "uninstall plugin validate_password;" >/tmp/pass.sql
mysql -u root -p"RoboShop@1" </tmp/pass.sql &>>$LOG
Status_Check $?


print "downloading schema\t"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG
Status_Check $?

print "extract schema file\t"
cd /tmp && unzip -o mysql.zip &>>$LOG
Status_Check $?

print "loading schema\t\t"
cd mysql-main && mysql -u root -pRoboShop@1 <shipping.sql &>>$LOG
Status_Check $?