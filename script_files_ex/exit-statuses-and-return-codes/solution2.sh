#!/bin/bash
#
# Exit statuses Solution 2

read -p "Enter in a file or directory name: " INPUT_NAME

if  [ -d $INPUT_NAME ]
  then
  echo "This is a directory."
  exit 0
elif [ -f $INPUT_NAME ]
  then
  echo " This is a regular file and the exit status code is " $?
  exit 1
else
  echo "This is some other type of file and the exit status is: = not valid cause the script ended first" $?
  exit 2
fi
