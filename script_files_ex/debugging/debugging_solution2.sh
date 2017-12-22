#!/bin/bash -x
#
# Author: jcbrent
# Created Date: 30 July 2017
# Write a shell script that exit on error and displays commands as they will execute, including all
# expansions and substitutions.  Use 3 ​ls​ commands in your script.
# Make the first one succeed, the second one fail, and the third one succeed.
# If you are using the proper options, the third ​ls command will not be executed.
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
GLOBAL_VAR1="one"
GLOBAL_VAR2="two"


echo " "
echo " Starting the \Debugging Solution 1\" Script  - Named:  \"debugging_solution1.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " Author:  Jim Brent "
echo " "
echo " This script exits on error and display commands as they will execute."
# Main body of the shell script starts here.
#


ls /etc/cron.d


ls  /etc/trusted-key

ls /etc/selinux





# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
