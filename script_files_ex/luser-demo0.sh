#!/bin/bash

# This displays things to the screen.

echo "hello world"

# Assign a value toa variable

WORD='script'

echo "$WORD"

# To reference by name must use the dollar sign $ - when you reference a variable by name you get its value back.
# Single quotes prevent the expansion of variables.
# If you want variables interpreted user double quotes.
#

# Demonstrate that single quotes cause variable to NOT get expanded.

echo '$WORD'

WORD2="experiment"


echo "---"

echo "$WORD2"

echo '$WORD2'

echo
echo "You must use the doube quotes with the curly braces {} to get a builtin variable."
echo " and use the correct name and case... such as HOSTNAME, not hostname"

echo

echo " as in \"\${HOSTNAME}\"  =   ${HOSTNAME}"

echo
