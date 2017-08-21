#!/bin/bash
# The above line is called shebang.
# Author: jcbrent
# Created Date: <yyy-mm-dd>
# Modified by: <Comma Delimited list>
#   < add to the Modified by list so we know who modified it last.
# <Replace with the description and/or purpose of this shell script.>
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
GLOBAL_VAR1="one"
GLOBAL_VAR2="two"


# Create Functions second - so they are read into the current bash session second
#------------- Sample below
function function_one() {
  local LOCAL_VAR1="one"
  # <Replace with function code.>
  echo "This script called the sample function (function_one) which does nothing (except print this line)."
}

echo " "
echo " Starting the \"Application Diagnostic Script/\" Script  - Named:  \"app_diagnostics.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " This script runs several checks on the applicaton to detemine the current status of the tool/application"
echo " "

# Main body of the shell script starts here.
#
# Here the file sizes of individual folders are printed first.

df -h
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "

df -h /home

echo " "
echo " ----------------------------------------------------------------------------- "
echo " "

# This is where the directory is listed for something like /var/log
ls -l /var/log

echo " "
echo " ----------------------------------------------------------------------------- "
echo " "

pgrep ttmswap
pgrep seapplet

echo " "
echo " ----------------------------------------------------------------------------- "
echo " "

# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
