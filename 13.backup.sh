#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # if 3 is empty, default is 14 days

USAGE(){
    echo "USAGE :: sh 13.backup.sh <source> <destination> <days(optional)>"
}

# check the source and destination dir provided

if [ $# -lt 2 ]
then
    USAGE
fi    

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR is does not exist ... please check"
fi 

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR is does not exist ... please check"
fi 

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS)
echo "files: $FILES"


if [ -n $FILES ]
then
    echo "FILES are found"
else
    echo "no files older than $DAYS"
fi      