#!/bin/bash
#
# Section 3 Functions Exercise 1
function file_count () {
  local WORKDIR=$(pwd)
  echo $WORKDIR
  # DOESN"T WORK   local FILECOUNT= ${WORKDIR} $( | wc -l)
  # DOESN'T WORK   echo FILECOUNT
  echo ${WORKDIR} | wc -l
}

file_count
