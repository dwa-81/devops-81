#!/bin/bash

USERID=$(id -u)

R="/e[31m"
G="/e[32m"
N="/e[0m"


CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo "please run this script with root"
    exit 1
fi    
}

VALIDATE(){
if [ $1 -ne 0 ]
then  
   echo -e "$2 is...$R FAILED $N"
   exit 1
else 
   echo -e "$2 is...$G SUCCESS $N"
fi

}

CHECK_ROOT

dnf install git -y

dnf list installed git 

if [ $? -ne 0 ]
then 
   echo "git is not istalled, going to installed it.."
   dnf install git -y
   VALIDATE $? "installing git"
else
   echo "git is already installed, nothing to do.."
 fi     

 dnf list installed mysql

 if [ $? -ne 0 ]
 then
    echo "mysql is not installed, going to installed it.."
    dnf install mysql -y
    VALIDATE $? "installing mysql"
else
   echo "mysql is already installed, nothing to do it.."  
fi     