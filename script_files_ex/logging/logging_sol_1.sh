#!/bin/bash
#
# Author: jcbrent
# Created Date: 27_Jul_2017
# Modified by:
# Write a shell script that displays one random number to the screen and also generates a syslog
# message with that random number.  Use the "user" facility and the "info" facility for your
# messages.
#
# Hint: Use $RANDOM
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
RANDOM_VAR=$RANDOM


echo " Starting the \"Logging Solution 1\" Script  - Named:  \"logging_sol_1.sh "
echo " ----------------------------------------------------------------------------- "
# Main body of the shell script starts here.
#
# Enter the script and create a random number. Then log it to the syslog = messages.log

echo " The random number is ${RANDOM_VAR}"
echo " "

#logger -p user.info $RANDOM_VAR
logger  -s -i -t logging_sol_1_script  -p user.info " The random number is ${RANDOM_VAR}"

# ------------------------------------------------------------------------------------
echo " ----------------------------------------------------------------------------- "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
exit 0
