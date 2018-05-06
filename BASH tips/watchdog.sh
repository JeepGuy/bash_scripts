#!/bin/bash
# Created by JCBrent  (with a little help from the walkthrough).
# This Script checks to see if a process is running and restarts it if it is not.
#

# Global VARS
EXIT_STATUS='0'

# Functions

# Determine if the user is running as root.
ROOT_PRIVILEDGES=""
check_root_priv() {
  if [[ "${UID}" -eq 0 ]]
  then
    # echo "   *** You are running this script with root priviledges." >&2
    ROOT_PRIVILEDGES="true"
  else
    # echo " You are running this script with your own priviledges." >&2
    ROOT_PRIVILEDGES="false"
  fi
}

# Required message function
display_message () {
  local MESSAGE="${@}"
  echo " ${MESSAGE} "  >&2
}

# Check service and restart if necessary
read_restart_service() {
  local SERVICE_NAME="${1}"
  shift
  local START_SERVICE_COMMAND="${@}"
  # Missed local timestamp idea
  local TIMESTAMP=$(date +'%b %d %T')
  echo ${TIMESTAMP} Checking service: "${SERVICE_NAME}" >> ${LOG_FILE}

  local SERVICE_PID=$(pidof ${SERVICE_NAME})

  # log result of the verify and restart operation performed for each host and service.
  if [[ -n "${SERVICE_PID}" ]]  # -n if this variable is empty then this statement is true.
  then
    echo "${TIMESTAMP} ${SERVICE_NAME} running as PID(s): ${SERVICE_PID}" >> ${LOG_FILE}
    return 0
  else
    echo "${TIMESTAMP} Restarting ${SERVICE_NAME} with command: ${START_SERVICE_COMMAND}" >> ${LOG_FILE}
    ${START_SERVICE_COMMAND} &>> ${LOG_FILE}
    return 1
    RETURN_STATUS='1'
  fi
}

# -----------------------
#   Main Body of Script
# -----------------------


check_root_priv
# Decide if Root Priveledges are acceptable or not comment out the code for the correct option...
if [[ "${ROOT_PRIVILEDGES}" = "true" ]]
  then
    OKorNOT="Yes, remember to comment out the correct if then else option"
    # display_message " You cannot run this script as root."
    # usage
    #exit 1
  else
    OKorNOT="No, remember to comment out the correct if then else option"
    display_message " You must run this script as root - use sudo."
    # usage
    exit 1
fi


# Verify the config file existance and location.
CONFIG_FILE="/vagrant/watchdog.conf.${HOSTNAME}"

if [[ ! -e "${CONFIG_FILE}" ]]
then
    display_message "   The config file does not exist for ${HOSTNAME}:  ${CONFIG_FILE}"
    EXIT_STATUS='1'
    exit 1
fi

# Verify log file existence and location # Create log file for each server
LOG_FILE="/vagrant/watchdog.log.${HOSTNAME}"

# This check wasn't necessary as the LOG_FILE was created once the function was called
# All this did was stop the script
#
# if [[ ! -e "${LOG_FILE}" ]]
# then
#     display_message "   The log file for ${HOSTNAME} does not exist:  ${LOG_FILE}"
#
#     # EXIT_STATUS='1'
#     # exit 1
# fi

# Missed adding the path to the PIDOF command
PATH="${PATH}:/usr/sbin"

# Verify that at least one process is running in the conf file:
#      - if not restart the process using sudo prefix and set the exist status of the script to status 2

while read LINE
do
  read_restart_service ${LINE}
  if [[ "${?}" -ne '0' ]]
  then
    EXIT_STATUS='2'
  fi

done < ${CONFIG_FILE}

exit ${EXIT_STATUS}
