#!/bin/bash

USERID=$(id -u)

# echo "user id is: $USERID"
if [ $USERID -ne 0 ]
then
    echo "please run this script with root"
    exit 1
fi    