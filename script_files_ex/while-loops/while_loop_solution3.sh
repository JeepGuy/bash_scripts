#!/bin/bash
#
# Author: jcbrent
# Created Date: 2017-07-27
#
#  Write a shell script that that allows a user to select an action from the menu.
# The actions are to show the disk usage, show the uptime on the system,
# and show the users that are logged into the system.
# Tell the user to enter ​q ​ to quit.
# Display "Goodbye!" just before the script exits.
# If the user enters anything other than ​1 ​, ​2 ​, ​3 ​, or q ​, tell them that it is an "Invalid option."
#
# You can show the disk usage by using the ​df​ command.
# To show the uptime, use the ​uptime command.
# To show the users logged into the system, use the who​ command.
# Print a blank line after the output of each command.
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
echo " Starting the \"While Loop Solution 3 /\" Script  - Named:  \"while_loop_solution3.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " Author:  Jim Brent "
echo " "
# Main body of the shell script starts here.
#
echo " Choose which system parameter you wish to display."
echo " For Disk Usage enter 1"
echo " For System Uptime enter 2"
echo " For Users who are logged into the system enter 3"
echo " To quit this program enter q"
echo " What would you like to do?"

echo " "

while true
do
  read -p "Select your choice: " USER_CHOICE
  case "$USER_CHOICE" in
    1)  df -h
        echo " "
        ;;
    2)
        uptime
        echo " "
        ;;
    3)
        who
        echo " "
        ;;
    q) break
          ;;
    *)
        echo "Not a valid option."
        echo " "
        ;;
  esac
echo "Goodbye!"
done

# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
