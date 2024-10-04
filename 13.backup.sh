#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # if 3 is empty, default is 14 days

USAGE(){
    echo "USAGE :: sh 13.backup.sh <source> <destination> <days(optional)>"
}



if [ $# -lt 2 ]
then
    USAGE
fi    

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR  does not exist ... please check"
fi 

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR  does not exist ... please check"
fi 

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)
echo "files: $FILES"


if [ -n $FILES ]   # -z shows if files empty  ! expression false
then
    echo "FILES are found"
else
    echo "no files older than $DAYS"
fi      


