#!/bin/bash

USERID=$(id -u)

# echo "user id is: $USERID"
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
else
   echo "git is already installed, nothing to do.."
 fi     

 dnf list installed mysql

 if [ $? -ne 0 ]
 then
    echo "mysql is not installed, going to installed it.."
    dnf install mysql -y
else
   echo "mysql is already installed, nothing to do it.."    