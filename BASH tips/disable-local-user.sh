#!/bin/bash
#
# Author: jcbrent
# Created Date: 2018-05-21
#  This script deletes user accounts...
# ------------------------------------------------------------------------------------

readonly ARCHIVE_DIR='/archive'

# Functions

# Create message function to echo messges sent to it.
message_func(){
  local MESSAGE="${1}"
  echo "${MESSAGE}"
}

# Usage function to provide basic useage instructions.
usage() {
  echo "Usage: ${0} [-dra]  USER [USERNAMES...]" >&2
        # >&2   Redirects STDOUT to STDERR and effectively squelches all command output.
  echo 'Delete or expire local user accounts.' >&2
  echo '  -d  Deletes accounts instead of disabling them.' >&2
  echo '  -r  Removes home directory of user.' >&2
  echo '  -a  Archive home directory of user(s).' >&2
  exit 1
}


# Verify the user is running as root.
if [[ "${UID}" -ne 0 ]]
then
  echo "You must run as root or use sudo." # >$2
  exit 1
fi

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
    echo "Cannot remove the ${USERNAME} account with the UID ${USERID}. Possible system account."
    exit 1
  fi

# Create an archive of the home dir if requested.
if [[ "${ARCHIVE}" = 'true' ]]
then
  if [[ ! -d "${ARCHIVE_DIR}" ]]
  then
    echo "Creating Archive Directory at ${ARCHIVE_DIR}."
    mkdir -p ${ARCHIVE_DIR}
      if [[ "${?}" -ne 0 ]]
      then
        echo " The archive directory ${ARCHIVE_DIR} could not be created" >$2
        exit 1
      fi
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
        tar -zcf "${ARCHIVE_FILE}"   "${HOME_DIR}" # &> /dev/null This did not work...
          if [[ "${?}" -ne 0 ]]
          then
            echo "${?}"
            echo "Could not create ${ARCHIVE_FILE}." >&2
            exit 127
          fi
      # add the instructor's else stmt.
      else
        echo "${HOME_DIR} does not exist."
        exit 2
  fi
fi

if [[ "${DELETE_USER}" = 'true'  ]]
then
  userdel ${REMOVE_OPTION} ${USERNAME}

  #Check if userdel successful
    if [[ "${?}" -ne 0 ]]
    then
      echo "Could not REMOVE ${USERNAME}." >&2
      exit 1
    fi
  echo "The account ${USERNAME} was deleted."
else
  chage -E 0 ${USERNAME}
    if [[ "${?}" -ne 0 ]]
    then
      echo "Could not disable ${USERNAME}." >&2
      exit 1
    fi
  echo "The account ${USERNAME} was disabled."
fi

done

exit 0

#  ./disable-local-user.sh: line 67: $2: ambiguous redirect
# Line 67      echo "Cannot remove the ${USERNAME} account with the UID ${UID}. Possible system account." >$2
