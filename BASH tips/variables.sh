#!/bin/bash

# This displays things to the screen.

echo "Variables single versus double quotes......."
echo
echo
# Assign a value to a variable
WORD='script'
echo "Set the variable and give it a value   WORD='script'   "

# To reference by name must use the dollar sign $
#  - when you reference a variable by name you get its value back.
# Single quotes prevent the expansion of variables.
# If you want variables interpreted use double quotes.
#
echo " Double quotes around a variable expand the variable - give the VALUE of the var."
echo " ------------------------------------------------------------------ "
echo "using a double quote: "
echo "$WORD"
echo
# Demonstrate that single quotes cause variable to NOT get expanded.
echo "Demonstrate that single quotes cause variable to NOT get expanded."
echo " ------------------------------------------------------------------ "
echo ' Using single quotation marks:  ${WORD} (inside this single quoted echo stmt ) or   $WORD '
echo '$WORD'
echo

WORD2="experiment"
echo "---"
echo "$WORD2"
# Displays the variable expression... not the assigned value of the variable.
echo '$WORD2  Displays the variable expression... not the assigned value of the variable.'

echo "hostname builtin variable:"
echo "host:"
echo  'hostname without quotes does not work'
echo  $hostname     "           - it was placed on this line"
echo
echo  '${hostname} without quotes does not work'
echo ${hostname}  "           - it was placed on this line"
echo
echo  '${hostname} with single quotes does not work but it does display the variable without expansion'
echo ' e.g. meaning it shows exactly what was written.'
echo '${hostname}'  "           - it was placed on this line"

echo   '${hostname} with double quotes does not work either'
echo   "${hostname}"


echo   'however hostname with nothing, no dollar sign or quotes DOES work why ???'
hostname
echo
echo   'Had the same problem with UID...'
echo
echo " ================================================================ "
echo

echo '${UID}'
echo "${UID}     - double quotes worked- however I still can't assign that to a variable... why?"

echo "${hostname}"


if [[ "${UID}" -ne 0 ]]
 then
   echo "UID not equal to zero... "
   echo "Why couldn't I get this to work in the script 1 assignment with variable assignment?"
   echo ' as in HELP_DESK_ID_GLOBAL=$(id -u)'

fi

UID_VALUE=UID
echo
echo
echo $UID_VALUE
echo " UID command is not found"

echo ${UID}   "doesn't work"

echo " hostname "
echo
echo "${HOSTNAME}"


echo

echo "Answer"
echo "You must use the doube quotes with the curly braces {} to get a builtin variable."
echo " and use the correct name and case... such as HOSTNAME, not hostname"

echo

echo " as in \"\${HOSTNAME}\"  =   ${HOSTNAME}"

echo
#
