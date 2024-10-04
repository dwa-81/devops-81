#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # if 3 is empty, default is 14 days
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)

USAGE(){
     echo "USAGE :: sh 13.backup.sh <source> <destination> <days(optional)>"
}



if [ $# -lt 2 ]
then
    USAGE
fi    


if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exists ... please"
fi

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR  does not exist ... please check"
fi 

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)
echo "files: $FILES"


if [ ! -z $FILES ]   # -z shows if files empty  ! expression false
then
    echo "FILES are found"
    ZIP_FILE="$DEST_DIR/app-log-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    
     if [ -f $ZIP_FILE ]
     then
        echo "successfully zipfile older than $DAYS"
        
          while IFS= read -r file
          do
              echo "deleting file: $file"
              rm -rf $file
          done <<< $FILES
     else
        echo "zipping the file is failed" 
        exit 1
     fi      
else
    echo "no files older than $DAYS"
fi      


