#!/bin/bash
#
# Script to add new users to the local computer.

# Ensure that the person executing the script has superuser (root) priviledges
# If not inform the user to re-exeute the script using sudo priviledges

if [[ ${UID} -ne 0 ]]
  then
  echo
  echo " You must execute this script with super user priviledges."
  echo "   Please re-execute this script preceeding it with sudo"
  exit 1
fi

# Verify that the command line arguements are supplied.
# If not provide a usage statement in the standard linux manual page format.

if [[ ${#} -eq 0 ]]   # $use octothorpe for number not asterick for all...
  then
  echo
  echo " No Username and comment (name) supplied."
  echo
  echo " Usage: ${0} USERNAME [COMMENT] ..."
  exit 1
fi

# Get the first command line argument use it for the new username
USER_NAME="${1}"

# Get the second command line argumet use it for the comment for the account.
shift
COMMENT="${@}"

# Generate a special character to append to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&\(\)-=+'  |fold -w1 | shuf |head -c1)

# Generate a random password for the account
PASSWORD_BASE="$(date +%s%N | sha256sum | head -c 48 )"

# Add the special character to the password
PASSWORD=${PASSWORD_BASE}${SPECIAL_CHARACTER}

# Create the new account   -c adds comments   -m forces the creation of a home dir.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Verify that the new account was created. Display error msg if not. exit status 1
if [[ "${?}" -ne 0 ]]
  then
  echo
  echo "The account could not be created for some reason, please try again"
  echo
  exit 1
fi

# Verify the password was set. Display error msg if not. exit status 1.

echo ${PASSWORD} |  passwd --stdin  ${USER_NAME}

# Verify the password set correctly
if [[ ${?} -ne 0 ]]
  then
  echo
  echo "The password was not set for some reason please try again"
  echo
  exit 1
fi

# Force password changes on first login - Expire the password
passwd -e ${USER_NAME}

#  Display the username password and host to the Help Desk Technician.
echo
echo "Username:"
echo ${USER_NAME}
echo
echo "Password"
echo ${PASSWORD}
echo
echo "Hostname:"
#  HOSTNAME is a builtin bash variable shell
echo ${HOSTNAME}
echo
# Set exit status
exit 0
