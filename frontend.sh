#!/bin/bash


LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDE

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

dnf install nginx -y 
VALIDATE $? "installing nginx"


systemctl enable nginx 
VALIDATE $? "ENABLE THE NGINX"

systemctl start nginx 
VALIDATE $? "START THE NGINX"

rm -rf /usr/share/nginx/html/* 
VALIDATE $? "REMOVE THE DEFAULT WEBSITE"
 
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip 

VALIDATE $? "DOWNLOADING THE FRONTEND APPLICATION"


cd /usr/share/nginx/html 

unzip /tmp/frontend.zip 
VALIDATE $? "EXTRACT FRONTEND CODE"
cp /home/ec2-user/devops-81/expense.conf /etc/nginx/default.d/expense.conf 
VALIDATE $? "copied expense conf"
systemctl restart nginx 
VALIDATE $? "RESTART NGINX"

