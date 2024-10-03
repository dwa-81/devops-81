#!/bin/bash

LOGS_FOLDER="/var/log/shell)"
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

dnf install mysql-server -y | tee -a $LOGS_FILE
VALIDATE $? -e " $G installing mysql sever $N "

systemctl enable mysqld | tee -a $LOGS_FILE
VALIDATE $? -e " $G enabled mysql sever $N "

systemctl start mysqld | tee -a $LOGS_FILE
VALIDATE $? -e " $G start mysql server $N "

mysql_secure_installation --set-root-pass ExpenseApp@1 | tee -a $LOGS_FILE
VALIDATE $? -e " $G setup root password $N "

