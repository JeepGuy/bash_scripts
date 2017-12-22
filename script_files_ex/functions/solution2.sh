#!/bin/bash
#
# Section 3 Functions Exercise 2
function file_count () {
  #local WORKDIR=$(pwd) first part of exercise - worked.
  # for local WORKDIR in /etc /var /usr/bin - this did not work - Why?
  local WORKDIR   # this worked
  for WORKDIR in /etc /var /usr/bin
  do
    echo ${WORKDIR}:
    echo $(ls ${WORKDIR} | wc -l)
  done
}

file_count

echo " "
echo "----- Now the correct way -----"
echo " "

function file_count_correct() {
  local WORKDIRCORR=$1
  local NUM_OF_FILES=$(ls $WORKDIRCORR | wc -l)
  echo "${WORKDIRCORR}:"
  echo "$NUM_OF_FILES"
}

file_count_correct /etc
file_count_correct /var
file_count_correct /bin
