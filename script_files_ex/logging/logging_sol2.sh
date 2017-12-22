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
# Modify the previous script so that it uses a logging function.
# Additionally tag each syslog
# message with "randomly" and include the process ID.  Generate 3 random numbers
#
# -i adds PID or process id
# -p adds logging facility and level
# -s adds output to the screen
# -t add a tag (no quotes needed)
#
#------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
MESSAGE1=$RANDOM
MESSAGE2=$RANDOM
MESSAGE3=$RANDOM

# echo $MESSAGE1

# Create Functions second - so they are read into the current bash session second
#------------- Sample below
function logit() {
  local LOG_LEVEL=$@
                            # echo $LOG_LEVEL
  shift    #shifts the input variable to exclude the name of the facility
  MSG=$@
                            # echo $MSG
  logger  -s -i -t randomly  -p user.info " The random number is ${MSG}"

}

echo " "
echo "Starting the \"Logging Solution 2 (with a function)\" Script  - Named:  \"logging_sol_2.sh\" "
echo " ----------------------------------------------------------------------------- "
# Main body     Logging three messages to the syslog "message.log"

logit user $MESSAGE1
logit user $MESSAGE2
logit user $MESSAGE3

# ------------------------------------------------------------------------------------
echo " ----------------------------------------------------------------------------- "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
