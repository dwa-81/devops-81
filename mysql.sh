#!/bin/bash

LOGS_FOLDER="(/var/log/expense)"
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

dnf install mysql-server -y &>>$LOGS_FILE
VALIDATE $? "installing mysql sever"

systemctl enable mysqld &>>$LOGS_FILE
VALIDATE $? "enabled mysql sever"

systemctl start mysqld &>>$LOGS_FILE
VALIDATE $? "start mysql server"

mysql -h mysql.daw81.online -u root -pExpenseApp@1 -e 'show databases;' &>>$LOGS_FILE
if [ $? -ne 0 ]
then
   echo "mysql password is not setup, setting now" &>>$LOGS_FILE
   mysql_secure_installation --set-root-pass ExpenseApp@1
   VALIDATE $? "setting up root password"
else
   echo "mysql password is already setup, nothing to do it" | tee -a $LOGS_FILE
fi 

   


