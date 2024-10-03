#!/bin/bash


LOGS_FOLDER="/var/log/expense)"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT(){
if [ $USERID -ne 0 ]    
then
   echo -e " $R please run the script with root prevelges $N " | tee -a $LOGS_FILE
   exit 1
fi
}

VALIDATE(){
if [ $1 -ne 0 ]
then
   echo -e " $R $2 is ...failure $N " | tee -a $LOGS_FILE
else       
   echo -e " $G $2 is ...success $N " | tee -a $LOGS_FILE
fi
}

echo -e " $Y script started executed at: $(date) $N " | tee -a $LOGS_FILE

CHECK_ROOT

dnf module disable nodejs -y &>>$LOGS_FILE
VALIDATE $? "disable default nodejs"

dnf module enable nodejs:20 -y &>>$LOGS_FILE
VALIDATE $? "module enable"

dnf install nodejs -y &>>$LOGS_FILE
VALIDATE $? "installing nodejs"

id expense &>>$LOGS_FILE

if [ $? -ne 0 ]
then
   echo "expense user is not create, create it now"
   useradd expense &>>$LOGS_FILE
   VALIDATE $? "create expense user"
else
   echo "expense user is already create, nothing to do "  
fi  

mkdir -p /app
VALIDATE $? "creating /app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
VALIDATE $? "downloading backend application"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip
VALIDATE $? "extracting backend application"

npm install

cp /home/ec2-user/devops-81/backend.services /etc/systemd/system/backend.service

dnf install mysql -y


mysql -h backend.daw81.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl daemon-reload

systemctl enable backend

systemctl restart backend