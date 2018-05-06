#/bin/bash
#
# This script executes commands on remote systems

# Global Variables
# -----------------
SUDO_PRIVILEDGES=''
VERBOSE=''

DEFAULT_SERVER_FILE='/vagrant/servers'




# Functions
# ---------

# Usage function

usage() {
  echo
  echo " Usage: ${0} [-nsv] [-f FILE] COMMAND"
  echo "    -f   FILE     File listing servers to act upon."
  echo "    -n            Runs the script as a dry run without changing any values."
  echo "    -s            Run with superusers - sudo (root) priviledges. "
  echo "    -v            Verbose mode - display name of server being acted upon."
  exit 1
}

display_message () {
  local MESSAGE-"${@}"
}

display_server_name() {
  local SERVER_NAME="${@}"
  if [[ "${SERVER_NAME}" = 'true' ]]
  then
    echo "${SERVER_NAME}"
  fi

}

# Verify the user is running AND they chose that selection.
check_root_priv_specific () {
  if [[ "${UID}" -eq 0 ]] && [[ "SUPERUSER_OPTION_SELECTED" -eq 'true' ]]
  then
    echo "   *** You are running this script with root priviledges." >&2
  else
    display_message " You are supposed to execute these commands as yourself, not the super user."
    usage
  fi
}

# Executes all arguments as a single command on every server listed in the file
# /vagrant/servers file by default - call only if no list of servers was passed as arguments.
check_static_server_file() {
if [[ ! -e "${SERVER_FILE}" ]]
then
  echo "Cannot open ${SERVER_FILE}"
  exit 1
fi
}

# Determine if the user is running as root.
# <TODO> Add to script include library
ROOT_PRIVILEDGES=''
check_root_priv() {
  if [[ "${UID}" -eq 0 ]]
  then
    echo "   *** You are running this script with root priviledges." >&2
    ROOT_PRIVILEDGES='true'
  else
    echo " You are running this script with your own priviledges." >&2
    ROOT_PRIVILEDGES='false'
  fi
}

#  Main Body
# ----------

# getops
  # echo " Usage: ${0} [-nsv] [-f FILE] COMMAND"
  # echo "    -f   FILE     File listing servers to act upon."
  # echo "    -n            Runs the script as a dry run without changing any values."
  # echo "    -s            Run with superusers - sudo (root) priviledges. "
  # echo "    -v            Verbose mode - display name of server being acted upon."
OPTIONAL_SERVER_FILE=''
# Parse command line options
while getopts fnsv OPTION
do
  case "${OPTION}" in
    f) OPTIONAL_SERVER_FILE="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO_PRIVILEDGES='true' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

# Shift options leaving the user accounts to act upon.
shift "$(( OPTIND - 1  ))"







# Executes all arguments as a single command on every server request
# ● Uses "ssh -o ConnectTimeout=2" to connect to a host. This way if a host is down, the script
# doesn't hang for more than 2 seconds per down server.
for SERVER in ${SERVER_LIST}   # or server file depending on params.
do
  echo "Pinging ${SERVER}"
  ping -c1 ${SERVER} &> /dev/null
  if [[ "${?}" -ne 0 ]]
  then
    echo "${SERVER} down."
  else
    echo "${SERVER} up."
  fi
done



# ● Executes the provided command as the user executing the script.



# ● Allows the user to specify the following options:
    # ○ -f FILE This allows the user to override the default file of /vagrant/servers. This way
    # they can create their own list of servers execute commands against that list.
    # ○ -n This allows the user to perform a "dry run" where the commands will be displayed
    # instead of executed. Precede each command that would have been executed with
    # "DRY RUN: ".
    # ○ -s Run the command with sudo (superuser) privileges on the remote servers.
    # ○ -v Enable verbose mode, which displays the name of the server for which the
    # command is being executed on.

# ● Enforces that it be executed without superuser (root) privileges. If the user wants the remote
#    commands executed with superuser (root) privileges, they are to specify the -s option.
# ● Provides a usage statement much like you would find in a man page if the user does not
#    supply a command to run on the command line and returns an exit status of 1. All messages
#    associated with this event will be displayed on standard error.



# ● Informs the user if the command was not able to be executed successfully on a remote host.






# ● Exits with an exit status of 0 or the most recent non-zero exit status of the ssh command.
