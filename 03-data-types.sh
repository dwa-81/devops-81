#!/bin/bash

NUMBER1=12
NUMBER2=13

SUM=$((NUMBER1+NUMBER2))

echo "total no id : $SUM"

echo "all variable passed to script: $@"
echo "number of variables passed: $#"
echo "script name: $0"
echo "current working directory: $PWD"
echo "home director of current user: $HOME"
echo " process id script executing: $$"