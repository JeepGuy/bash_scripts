#!/bin/bash
#
# Author: jcbrent
# Created Date: 2017_07_28
# Modified by: <Comma Delimited list>
#  Write a shell script that asks the user for the number of lines they would like to display from the
# /etc/passwd file and display those lines.
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
LINE_NUM=1
NUM_LINE_READ=""

# Create Functions second - so they are read into the current bash session second


echo " "
echo " Starting the \"While Loop Solution 2/\" Script  - Named:  \"while_loop_solution2.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " Author:  Jim Brent "
echo " "
echo " Script to read Lines from /etc/passwd"
# Main body of the shell script starts here.

read -p " Please enter the number of lines to read in \/etc\/passwd: " NUM_LINE_READ
# echo $NUM_LINE_READ # worked

while read LINE_IN
do
  if [ "$LINE_NUM" -gt "$NUM_LINE_READ" ]
  then
    break
  fi
    echo " ${LINE_IN}"
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
