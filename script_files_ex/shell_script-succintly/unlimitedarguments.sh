#!/bin/bash
#
# This is a script for outputting the type of file a file is...
# Notes:
# -f is a regular file
# -e file exists

# INPUT_NAME="/etc/vimrc"
echo "-----------------------------------"
echo "-----------------------------------"
echo "-----------------------------------"
# looping 

INPUT_NAME="  etc /etc/vimrc  /etc/abrt"

for INPUT_NAME in $INPUT_NAME

do

if [ -d $INPUT_NAME ]
then 
	echo "The file exists and is a directory"
	ls -l $INPUT_NAME

elif [ -f  $INPUT_NAME ]
then
        echo "The file exists and is a regular file"
	ls -l $INPUT_NAME

elif  [ -e $INPUT_NAME ]
then  
	echo "The file is a another type of file"
	ls -l $INPUT_NAME
else
        echo " The file does not exist."
fi

done

