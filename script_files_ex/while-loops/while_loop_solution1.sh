#!/bin/bash
#
# Author: jcbrent
# Created Date: 2017-07-29
# Modified by: <Comma Delimited list>
# Write a shell script that loops through the /etc/passwd file one line at a time.
# Prepend each line with a line number followed by a colon and then a space.
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
LINE_NUM=1

echo " "
echo " Starting the \"While_loop_solution1/\" Script  - Named:  \"while_loop_solution1.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo "Reading through the /etc/passwd File line by line"
echo " "
# Main body of the shell script starts here.
# While loop to read each line.


while read LINE
do
  echo " ${LINE_NUM}: ${LINE}"
    ((LINE_NUM++))
done < /etc/passwd


# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
