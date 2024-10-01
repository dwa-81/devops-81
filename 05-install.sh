#!/bin/bash

USERID=$(id -u)

if (USERID -NE 0)
then
    echo "run this script with root"
fi    