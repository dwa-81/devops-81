#!/bin/bash


USERID=$(id -u)
R="\e[31m"
G="\e[31m"
Y="\e[33m"
N="\e[0m"


CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo -e " $R please run the script with root preveleges"
    exit 1
}

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo -e " $R $2 is ... failure $N "
else
   echo -e " $G $2 is... success $N "
fi   
}

CHECK_ROOT

