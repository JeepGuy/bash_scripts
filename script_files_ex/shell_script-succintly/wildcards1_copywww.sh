#!/bin/bash
#
#Section 6 exercise 1 Rename all files in the current directory that end in .jpg

# Line for handling error when no .jpg files exist in the directory
shopt -s nullglob
# exit 1 can't do this becase the script exits


echo "-------------"

#yyy-mm-dd
DATE=$(date +%F)

echo "The date is ${DATE}"


for FILE in *.jpg
do
     echo "Renaming $FILE in the current directory"
     mv @FILE   ${DATE}-${FILE}
done

echo " "
echo "Script Completed correctly exit status 0 (zero)"

exit 0
