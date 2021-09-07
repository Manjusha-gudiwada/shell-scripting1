#!/bin/bash

Status_Check()
 {
 if [ $1 -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
 else
  echo -e "\e[31mFAILURE\e[0m"
  exit 2
 fi
 }
 
 print()
  {
   echo -e "\n\t\t\e[36m---------------$1------------\e[0m\n" >>$LOG
   echo -n -e "$1 \t- "
  }
  
  
  if [ $UID -ne 0 ]; then
  
  echo -e "\n\e[33mYou should execute this script as root user\e[0m\n"
  exit 1
  
  fi

LOG=/tmp/roboshop.log
rm -f $LOG

ADD_APP_USER() {

print "adding roboshop user\t"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
echo "user exists so skipping this step" &>>$LOG

else
useradd roboshop &>>$LOG
fi
Status_Check $?

}

DOWNLOAD() {
print "downloading ${component} "
curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/${component}/archive/main.zip"
Status_Check $?

print "Extracting ${component}"
cd /home/roboshop
# in order to avoid many times unzip of file we are removing content inside it before running
rm -rf ${component} && unzip /tmp/${component}.zip &>>$LOG && mv ${component}-main ${component}
Status_Check $?

}

SystemD-Setup() {

  print "update systemd service"

sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/${component}/systemd.service
Status_Check $?

print "setup systemD service file"

mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service && systemctl daemon-reload && systemctl restart ${component} &>>$LOG && systemctl enable ${component} &>>$LOG
Status_Check $?

}

NODEJS() {

print "Installing nodejs"

yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

ADD_APP_USER
DOWNLOAD

print "downloading nodejs dependencies"
cd /home/roboshop/${component}
npm install --unsafe-perm &>>$LOG # this is written becoz we have to switch to user and install
Status_Check $?

chown roboshop:roboshop -R /home/roboshop

SystemD-Setup


}