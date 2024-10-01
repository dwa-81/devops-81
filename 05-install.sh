#!/bin/bash

USERID=$(id -u)

# echo "user id is: $USERID"
if [ $USERID eq 0 ]
then
    echo "please run this script with root"
fi    