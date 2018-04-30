#/bin/bash
# maps to .user-demo09.sh
#
# This script demonstrates the case statement demo-luser-demo-09.sh.

echo "use the type -a command to find out that case statements is a shell builtin"
echo
# type -a case
# case is a shell keyword

echo "If then stmts are not the best way to handle decisions for on multiple possibilities..."
echo
# IF-ELIF-ELSE
# ------------
# EXAMPLE:

# if [ condition-is-true ]
# then
# command N
# elif [ condition-is-true ]
# then
# command N
# else
# command N
# fi

# Not the best solution
# if [[ "${1}" = 'start' ]]
# then
#   echo 'Starting'
# elif [[  "${1}" = 'stop' ]]
# then
#   echo 'Stopping'
# elif [[ "${1}" = 'status' ]]
# then
#   echo 'Status:'
# else
#   echo 'Supply a valid option.'  >&2
# echo # because the exit staus forces us out of the script.
#   exit 1
# fi
# echo

# Now use a case statement. Use the formnat of indenting by two spaces for each nested line.
# case "${1}" in
#   start)
#     echo 'Starting'  # if you want to execute many lines of code just use separate lines.
#     ;;
#   stop)
#     echo 'Stopping'
#     ;;
#   status|state|--status|stat*) # use a pipe bar to match many options that are similar.
#     echo 'Status'
#     ;;
#   *)
#     echo 'Pleaes supply a valid argument'
#   ;;
# esac

# The new more modern format for a Case Statement - spacing and style.
#    If you are only matching 1 pattern is convention to put all the code on one line
case "${1}" in
  start) echo 'Starting' ;;
  stop) echo 'Stopping' ;;
  status) echo 'Status' ;; # it is customary to leave the last match in long format.
  *)
    echo 'Please supply a valid argument or option.'
  ;;
esac
