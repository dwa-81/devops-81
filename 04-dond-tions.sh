#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 20 ] #gt, lt, eq, -ne, -ge, -le
then
    echo "give number is: $NUMBER is grater than 20"
else
    echo "give number is: $NUMBER is less than 20"
fi        