#!/bin/bash
#
# This script demonstrate functions.
# ------------------------------------------------------------------------------------


# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
GLOBAL_VAR1="one"
GLOBAL_VAR2="two"


# Create Functions second - so they are read into the current bash session second

# If you create a gloval variable by ommitting the local keyword...
#     that variable is not available outside the function until that function is called and executed.
# it sia best practice to use only local variable in a funciton
# that way you won't accidentially use the same name for a variable elsewhere and
# create a hard to find bug in your program.

#------------- Two Samples below
function function_one {
  local LOCAL_VAR1="one"
  # <Replace with function code.>
  echo "This script called the sample function (function_one) which does nothing (except print this line)."
}
# call the function ------- just write the name of the funciton like a linux scommand
# function_one


# different way.
function_two() {
  local LOCAL_VAR2="two"
  # <Replace with function code.>
  echo "This script called the sample function (function_two) which does nothing (except print this line)."
}
#call the function two
# function_two


 #Prefferred way...
# The log function.

#
# log() {
#   # The local variable is scoped to the function only...
#   local VERBOSE="${1}"
#   shift # skicks out the first argument and re-numbers all the remaing arguments.
#   local MESSAGE="${@}"
#   # @ expands to all positional parameters  starting from 1 (not 0)
#   # $0 is still that name of the shell script itself... not the function...
#   #     echo '${MESSAGE}'     this does not expand the variable so it is wrong.
#   if [[ "${VERBOSE}" = 'true' ]]
#   then
#     echo "${MESSAGE}"
#   fi
# }
#
# # Body of the script
# # ------------------
# # call the function
# log 'true' 'Hello!'
# # ########## no longer needed... VERBOSE='true'
# # or... using a global variable... Which is often called evil or dangerous.
# VERBOSITY='true'
# echo
# log "${VERBOSITY}"  'This is fun!'
# echo


log() {
  # Function sends a message syslog and to STDOUT if verbose is true.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
logger -t luser-demo10.sh "${MESSAGE}"
}


backup_file() {
  # Back up script for a file Returns non-zero statu on error.

   # Files in /tmp will not survive a reboot... file in tmp are cleared on boot and cleared more often n a running system
   # centos 7 - default /tmp are deleted every 10 and /var/tmp are cleared every 30 days.
   # AND  /var/tmp will survive a reboot.
  local FILE="${1}"

  # Make sure the file exists.
  if [[ "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    # basename command strips out the path and leaves the filename.
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command.
    cp -p ${FILE} ${BACKUP_FILE}
# -p stands for preserves = preserves the files mode, ownership, and timestamps
  else
    # The files doesn't exit, so return a non-zero exit status.
    return 1   # if you use the exit keyword/command it will kill the script
  fi
}


# Body of the script
# ------------------

# call the function
readonly VERBOSE='true'   # readonly is the shell version of a constant variable.
#### This eliminates the danger of a global variable being reset - if appropriate for your script.
# optionally syntax... VERBOSE='true' readonly
#   type -a logger .... command line utility executiabl;e so use the man page.
# -t option is the key one for this case.
echo
log 'Hello!'
log 'This is fun!'
echo

backup_file '/etc/passwd'

# Make a decision based on the exit status of the function.
if [[ "${?}" -eq '0' ]]
then
  log 'File Back up succeded'
else
  log 'File backup failed!'
  exit 1
fi
