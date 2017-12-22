#!/bin/bash
#
# Author: Jim Brent Sr.
# Created Date: 2017_07_23 aka 23 Jul 17
# Modified by:
#
# Bash start up script called sleep_walking.sh
# Used for case statements exercise
# This assumes that you put a script called sleep-walking-server (.pid)
# in the tmp directory
# ------------------------------------------------------------------------------------

# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
GLOBAL_VAR1="one"
GLOBAL_VAR2="two"


echo " Starting the \"Sleep Walking Server Solution \" Script\" "
echo " - Named:  \"sleep-walking-server.sh\" "
echo " ----------------------------------------------------------------------------- "
#
# Create a startup script for an application called sleep­walking­server, which is provided below.
# The script should be named sleep­walking and accept "start" and "stop" as arguments.  If
# anything other than "start" or "stop" is provided as an argument, display a usage statement:
# "Usage sleep­walking start|stop" and terminate the script with an exit status of 1.
#
# To start sleep­walking­server, use this command: "/tmp/sleep­walking­server &"
#
# To stop sleep­walking­server, use this command: "kill $(cat /tmp/sleep­walking­server.pid)"

# ### this is what was implied:   read -p "Enter start or stop to control the sleepwalking pid: " ANSWER

# case "$ANSWER" in
case "$1" in
  start)
    /tmp/sleep-walking-server &
    ;;
  stop)
    kill $(cat /tmp/sleep-walking-server.pid)  # Produces no such file error UNLESS the process is started first!!!
    # kill $(cat /tmp/sleep-walking-server) # also doesn't work... see error messages below
    ;;
    *)
        echo "Usage sleepwalking start|stop  (setting the exit status to one)"
        exit 1
        echo $?  #   will not run because the exit status 1 exits the script first.
    ;;
esac


# FROM SOLUTION FILE: This doesn't work unless you pass the argument when calling the script.
# case "$1" in
#   start)
#     /tmp/sleep-walking-server &
#     ;;
#   stop)
#     kill $(cat /tmp/sleep-walking-server.pid)
#     ;;
#   *)
#     echo "Usage: $0 start|stop"
#     exit 1
# esac




# ------------------------------------------------------------------------------------
echo ""
echo " ----------------------------------------------------------------------------- "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
exit 0


# ./sleep_walking.sh: line 41: kill: $PID_FILE: arguments must be process or job IDs
# ./sleep_walking.sh: line 41: kill: while: arguments must be process or job IDs
# ./sleep_walking.sh: line 41: kill: true: arguments must be process or job IDs
# ./sleep_walking.sh: line 41: kill: do: arguments must be process or job IDs
# ./sleep_walking.sh: line 41: kill: :: arguments must be process or job IDs
# ./sleep_walking.sh: line 41: kill: done: arguments must be process or job IDs
