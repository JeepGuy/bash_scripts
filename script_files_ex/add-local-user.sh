#!/bin/bash
# Script Name:   add-local-user.sh
# Author: jcbrent
# Created Date: 7 April 2018
# Modified by: J Brent
# Modified Date(s): 9 April 2017
# Modified Code: Fixed variable assignments and removed unnecessary clean up function
#
# Style Guide: This script is written to conform to the Google Bash Script Style
#              Guide available at:  https://google.github.io/styleguide/shell.xml
# PURPOSE:
# Script to add new users to the system, for help desk personnel with Admin priviledges (root access).
# ------------------------------------------------------------------------------------


# Set Global Variables first  so they are always defined before being called.
#-------------------------------------------------------------------------------
NAME_OF_COMPUTER_GLOBAL_VAR='localusers'
HELP_DESK_ID_GLOBAL=''
NEW_USERS_USERNAME=''
NEW_USERS_REALNAME=''
NEW_USERS_PASSWORD=''
ACCOUNT_CREATED=''
PASSWORD_SET=''

# Functions
#------------- Sample below
function function_one() {
  local local_var_1="one"
  echo " "
  echo " Starting the \"add-local-user.sh/\" Script "
  echo " ----------------------------------------------------------------------------- "
  echo " "
  echo " This script enables help desk personnel with proper authority to add new users to the ${localusers} computer. "
  echo "      ${local_var_1} at a time."
  echo " ---------------------------------------------------------  Author:  Jim Brent "
}

# Clean up any variables, parameters, or temporary files#
# ------------------------------------------------------
#   NOT REQUIRED
# When a shell script is run, a new instance of bash is created to run the script.
#  When the script ends, that instance goes away.
# That means that you usually don't need to clean up variables when a script is done executing
# - they were only set in the temporary shell environment.
# ------------------------------------------------------
# function function_cleanUp() {
#   HELP_DESK_ID_GLOBAL=''
#   NEW_USERS_USERNAME=''
#   NEW_USERS_REALNAME=''
#   NEW_USERS_PASSWORD=''
#   ACCOUNT_CREATED=''
# }


# ------------------------------------------------------------------------------------
# Main body of the shell script starts here.
# ------------------------------------------------------------------------------------

# Print the name of the script and purpose for the help desk user.
# Function called function_one for brevity and portability to other scripts.
function_one


# Check to see if the user has root priviledges
# ------------------------------------------------------------------------------------

# HELP_DESK_ID_GLOBAL=$(id -u) ... works but not optimal ...
# HELP_DESK_ID_GLOBAL=$(UID)  WRONG SYNTAX
HELP_DESK_ID_GLOBAL=${UID}
# if [[ ${HELP_DESK_ID_GLOBAL} -ne "0" ]]
# if [[ ${UID} -ne "0" ]]
if [[ ${HELP_DESK_ID_GLOBAL} -ne "0" ]]
  then
    echo "You must have root priviledges in order to add a user to the system."
    echo "   - If you have sudoers priviledges run the script preceeded by the sudo command"
    echo "   - If not, inform your tech lead or supervisor."
    echo " "
    # function_cleanUp   NOT REQUIRED as shell scripts end with the shell that called them.
    exit 1
fi

# Experiment with double quotes versus single quotes in the next read commands.

# Enter in new user's username (use 8 character SID recommended)
#---------------------------------------------------------------

read -p " Enter the new user's username, (8 digit SID recommended): " NEW_USERS_USERNAME


# Enter in new user's real name
#------------------------------

read -p " Enter the new user's real name: " NEW_USERS_REALNAME


# Enter in new user's password  (use new username plus 123 recommended)
#----------------------------------------------------------------------

read -p ' Enter the password for the new user: ' NEW_USERS_PASSWORD

# Create new user account
#------------------------------

useradd -c "${NEW_USERS_REALNAME}" -m ${NEW_USERS_USERNAME}


# Capture exit value of above command
ACCOUNT_CREATED=${?}


# Confirm susccessful account creation
#-------------------------------------

if [[ ${ACCOUNT_CREATED} -ne "0" ]]
  then
    echo "Account not created for some reason. Please try again."
    echo " "
    # function_cleanUp BOT REQUIRED BECAUSE  --- shell scripts end with the shell that called them.
# When a shell script is run, a new instance of bash is created to run the script.
#  When the script ends, that instance goes away.
# That means that you usually don't need to clean up variables when a script is done executing
# - they were only set in the temporary shell environment.
    exit 1
fi

# Set the password of the new account.
#-------------------------------------

echo ${NEW_USERS_PASSWORD} | passwd --stdin ${NEW_USERS_USERNAME}

# Capture exit value of above command
PASSWORD_SET=${?}

if [[ ${PASSWORD_SET} -ne "0" ]]
  then
    echo "Password not set for some reason. Please try again."
    echo " "
    exit 1
fi

# Require the user to set a new password at first login.
#-------------------------------------------------------

passwd -e ${NEW_USERS_USERNAME}


# Print out the new username, password and the hostname of computer
#    on which the account was created
#------------------------------------------------------------------
echo " "
echo "username: "
echo ${NEW_USERS_USERNAME}
echo
echo "password:"
echo ${NEW_USERS_PASSWORD}
echo "host:"
echo
#  WORKED because it was a command... echo  hostname
# Use Bash builtin vaiable instead which is in all capitals and must be surrounded by curly braces {}
echo ${HOSTNAME}



# Script clean up function to ensure it will run correctly next time.
# -------------------------------------------------------------------
 # NOT REQUIRED because the instance of this script is delete with the end of the shell session
#       function_cleanUp


# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
