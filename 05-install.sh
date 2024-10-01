#!/bin/bash

USERID=$(id -u)

if (USERID -ne 0)
then
    echo "run this script with root"
fi

