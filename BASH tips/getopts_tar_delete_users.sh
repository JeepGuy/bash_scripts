#!/bin/bash
#
# Author: jcbrent
# Created Date: 2018-05-21
# Modified: version 2 by JCBrent 2018-05-22
#  - Add functions and fix typos.
#
#  This script disables or deletes user accounts based on passed args (inputs)...
# ------------------------------------------------------------------------------------

# constants, global variables and library functions should be put in an include file.
# <TODO> Create include library.
# Do not include script library in the course examples for easy of grading.
# From the source file "includeFiles/config.sh"
# source includeFiles/config.sh
# source includeFiles/gloval_vars.sh
# source functions/lib_funcitons_admin.sh

# Global Vars and readonly Vars (Constants)
# ------------------------------------------
readonly ARCHIVE_DIR='/archive'

# Functions
# ----------
# Create message function to echo messges sent to it.
# <TODO> Add to script include library
message(){
  local MESSAGE="${1}"
  echo "   *** ${MESSAGE}"
}

success_check(){
    # Check the status code of last command.
    local RETURN_CODE="${1}"
    local ERROR_MESSAGE="${2}"
    local EXIT_STATUS_CODE="${3}"

    if [[ "${RETURN_CODE}" -ne 0 ]]
    then
      echo "   ***   ${ERROR_MESSAGE}" >&2
      if [[ "${EXIT_STATUS_CODE}" ]]
      then
        exit "${EXIT_STATUS_CODE}"
      else
        exit 1
      fi
    fi
}

# Verify the user is running as root.
# <TODO> Add to script include library
check_root_priv () {
  if [[ "${UID}" -ne 0 ]]
  then
    echo
    echo "   *** You must run as root or add the sudo (command) before the script name." >&2
    echo
    exit 1
  fi
}

# Usage function to provide basic usage instructions.
usage() {
  echo
  echo "Usage: ${0} [-dra]  USER [USERNAMES...]" >&2
        # >&2   Redirects STDOUT to STDERR and effectively squelches all command output.
  echo 'Delete or expire local user accounts.' >&2
  echo '  -d  Deletes accounts instead of disabling them.' >&2
  echo '  -r  Removes home directory of user.' >&2
  echo '  -a  Archive home directory of user(s).' >&2
  echo
  exit 1
}

# ----------------------------
#     Main body of script
# ----------------------------

# Check for root priviledges - call function
check_root_priv

# Parse command line options
while getopts dra OPTION
do
  case "${OPTION}" in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    ?) usage ;;
  esac
done

# Shift options leaving the user accounts to act upon.
shift "$(( OPTIND - 1  ))"

# If no user account supplied display usage stmt in function.
if [[ "${#}" -lt 1 ]]
then
  usage
fi

# Loop throught arguements as usernames
for USERNAME in "${@}"
do
  echo Processsing user: ${USERNAME}

  # Make sure this is not a system account.
  USERID=$(id -u ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    message "Cannot remove the ${USERNAME} account with the UID ${USERID}. Possible system account."
    exit 1
    # This could be modified to call the success_check function.
  fi

  # Create an archive of the home dir if requested.
  if [[ "${ARCHIVE}" = 'true' ]]
  then
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then
      echo "Creating Archive Directory at ${ARCHIVE_DIR}."
      mkdir -p ${ARCHIVE_DIR}
        # Verify the last command executed correctly
        success_check "${?}"  "The archive directory ${ARCHIVE_DIR} could not be created" '2'
     fi

      # Archive user's nome directory and move it into that directory.
    HOME_DIR="/home/${USERNAME}"
    # if [[ ! -d "${HOME_DIR}" ]] Reversed logic - not nots are too complicated.
    if [[ -d "${HOME_DIR}" ]]
      then
      #   echo "User home directory does not exist... check with sysadmin before continuing"
      #   exit 1
      # else
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
        echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
        tar -zcf "${ARCHIVE_FILE}"   "${HOME_DIR}" &> /dev/null
  # &> /dev/null did not work because the ARCHIVE_DIR was missing the closing }
  # STDERR was vague - forgot to fix after finding the real problem.  DELETE BEFORE FINAL
            # Verify last command executed successfully
          success_check "${?}"  "Could not create ${ARCHIVE_FILE}." '1'
        else
          # Send message to user - return code 1 to print the message then return code 0 so the script does not exit.
          success_check '1' "${HOME_DIR} does not exist." '0'
    fi
  fi

  if [[ "${DELETE_USER}" = 'true'  ]]
  then
    userdel ${REMOVE_OPTION} ${USERNAME}

    #Check if userdel successful
      success_check  "${?}"  "Could not REMOVE ${USERNAME}."  '1'
    # If success_check fails script will exit (terminate)
    echo "The account ${USERNAME} was deleted."
  else
    chage -E 0 ${USERNAME}
    #Verify chage successful.
      success_check  "${?}"  "Could not disable ${USERNAME}."  '1'
  # If successful script will continue.
    echo "The account ${USERNAME} was disabled."
  fi
done

exit 0

#  ./disable-local-user.sh: line 67: $2: ambiguous redirect
# FIGURED OUT Typing error...
# Touch typing -using left index finger instead of right index finger.
