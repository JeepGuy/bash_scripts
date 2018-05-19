#!/bin/bash
# Author: jcbrent
# Created Date: 2018-05-19
#  This script describe how to work with getopts...
# ------------------------------------------------------------------------------------

# getopt is an old executible on the file system and different from getopts.

# Generate a password...
# This user can set the password length with -l and
# add a spcial character with -s.
# Verbose mode can be enabled with -v.


# functions
useage() {
  echo "Usage: ${0} [-vs]  [-l LENGTH]" >&2  # >&2   Redirects STDOUT to STDERR.
  echo 'Generate a random password.'
  echo '  -l  LENGTH  Specify the password length.'
  echo '  -s          Append a special character to the password.'
  echo '  -v          Verbose ouput.'
  exit 1
}

# log is not a good name for this function but it gives you an idea of what this does..
log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi

}



# Set a default password length
LENGTH=48

while getopts vl:s OPTION
 # the colon specifies that he -l option is required.
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      # change to the log local funciton   echo 'Verbose mode on.'
      log 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)  # question mark matches a single pattern - could have used  *
      #  echo 'Invalid opton.'  >&2  Instead teach the users how to use this function.
      # exit 1
      useage
      ;;
  esac
done

echo "getopts does NOT change positional parameters..."
echo
echo 'This means the the values or options are stored in $1 $2 $@ and cannot be moved with shift command.'
echo ' ${#}'
echo "Number of args: ${#}"
echo ' ${@}'
echo "All args: ${@}"
echo ' ${0}'
echo "Arg 0 - also known as (aka) the name of the script ${0}"
echo ' ${1} ... etc... '
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"
echo
# Inspect OPTIND
echo "GETOPS gives us OPTIND which stores the positional paramaters."
echo
echo "OPTIND: ${OPTIND}"

echo
echo " To shift the positional parameters as they are used use math... "
echo "    as in OPTIND - 1   ..."
echo

echo "Remove the options while leaving the reamining arguments..."
echo 'shift $(( OPTIND -1 ))'
shift "$(( OPTIND - 1 ))"
echo "After the shift"

echo
echo "Number of args: ${#}"

echo "All args: ${@}"

echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

# Now test for extra arguments and make a decision based on the answer.
if [[ "${#}" -gt 0 ]]
then
  useage    # call the function
fi


log 'Generating a password'
# This will work but will give us a lot of repeated code..
####### Instead move this into a function...
# if [[ "${VERBOSE}" = 'true' ]]
# then
#   echo 'Generating a password.'
# fi

PASSWORD=$(date +%x%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested by user.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]];
then
    log 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf |head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done'
log 'Here is the password'

# Display password
echo "${PASSWORD}"
