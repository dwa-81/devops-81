#!/bin/bash
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
R="\e[31m"
G="\e[31m"
Y="\e[33m"
N="\e[0m"


CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo -e " $R please run the script with root preveleges $N " | tee -a $LOGS_FILE
    exit 1
fi    
}

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo -e " $R $2 is ... failure $N " | tee -a $LOGS_FILE
else
   echo -e " $G $2 is... success $N " | tee -a $LOGS_FILE
fi   
}

echo "script started executing at: $(date)" | tee -a $LOGS_FILE

CHECK_ROOT

