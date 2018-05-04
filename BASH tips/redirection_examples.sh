#!/bin/bash
#
# This script demonstrates I/O redirection.

# redirect STDOUT to a file.
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

#Redirect  STDIN to a program.
read LINE < ${FILE}
echo "LINE variable contains: ${LINE}"

# Difference betwee a pipe and a redirect.
# use a pipe whn you want to take output from a command
# use redirection when you want to redirect the contents of file into a command.

echo " single > creates a file or over writes the contents of a file if it does exist."

# Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Content of ${FILE}"
cat ${FILE}

# Redirect STDOUT to a file appending t that file.... use two >> to ADD to a file.
echo "${RANDOM}  ${RANDOM}" >> ${FILE}
cat ${FILE}

#File descriptors
echo " File Descriptor is abbrevated FD"
echo
echo "There are three kinds of File Descriptors"
echo
echo "FD 0 - STDIN (zero)"
echo "FD 1 - STDOUT"
echo "FD 2 - STDERR"
echo

echo "If you don't supplied a file descriptor then 0 is assumed"
echo

# Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file useing FD 1
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

# Redirect STDERR to a file useing FD2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}


#Redirect STDOUT and STERR to a file.
#Old Format
head -n3 /etc/passwd /fakefile 2&> ${FILE}
# New format
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

#Redirect STDOUT and STDERR through a pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Redirect Send output to STDERR
echo "This is STDERR!" >&2

# Redirect the script to a file
# ./luser-demo08.sh  2> err.file

# the null device aka the bit bucket...
# > /dev/null   FOR STDOUTPUT
# for std error =     2> /dev/null
#
# to throw away all output... redirect stdout and stderr to dev nu..
# &> /dev/null
### THE USE CASE is if we want to suppress all output to the screen AND we check for
### success of each command using echo ${?}

# Discard STDOUT
echo
echo " -----------------------------------------------------"
echo
echo "Discard STOUT: "
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STDERR
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo
echo " Discarding STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &>/dev/null
echo

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
