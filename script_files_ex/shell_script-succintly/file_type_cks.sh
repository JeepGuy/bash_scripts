#!/bin/bash
#
# This is a script for outputting the type of file a file is...
# Notes:
# -f is a regular file
# -e file exists

INPUT_NAME="/etc/vimrc"

echo "-----------------------------------"

# read -p "type the file name of directory of an object to find out its # file type. :  " INPUT_NAME

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


