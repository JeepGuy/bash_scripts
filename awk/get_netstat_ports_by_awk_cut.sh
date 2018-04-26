#!/bin/bash
#
# This script shows the open network ports on a system.
# Use  -4 option as an argument to linit to tcpv4 ports.


# use the first argument as a dash 4 to use as the ipv4 limiter... NOT too safe.

#can put in a an if then to check to ensure that the arg is -4
netstat -nutl ${1} | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'

# -p shows the listeners but must be done with sudo priviledges
