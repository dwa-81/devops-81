#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # if 3 is empty, default is 14 days

USAGE(){
    ecgo "USAGE :: sh 13.backup.sh <source> <destination> <days(optional)>"
}

# check the source and destination dir provided

if [ $# -lt 2 ]
then
    USAGE
fi    

