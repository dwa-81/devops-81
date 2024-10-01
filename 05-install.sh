#!/bin/bash

USERID=$(id -u)

# echo "user id is: $USERID"

VALIDATE(){
if [ $1 -ne 0 ]
then  
   echo "$2 is...FAILED"
   exit 1
else 
   echo "$2 is...SUCCESS"
fi

}

if [ $USERID -ne 0 ]
then
    echo "please run this script with root"
    exit 1
fi    

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