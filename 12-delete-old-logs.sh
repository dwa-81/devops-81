#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs

R="\e[31m"
G="\e[31m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR is exists"
else
    echo "$SOURCE_DIR is does not exists"
    exit 1
fi


FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "files :$FILES"
