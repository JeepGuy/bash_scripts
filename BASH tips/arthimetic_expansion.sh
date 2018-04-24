#!/bin/bash
# Author: jcbrent
# Created Date: 2018-05-20
#  This script describe how to work with arthimetic expansion and is related to getopts...
# ------------------------------------------------------------------------------------

echo 'Bash arthimetic - bash will evaluate the mathematical expression in the inner parens'
echo '   and then evalute the remaining result and assign it to the variable NUM.'
echo
echo ' Addition:   NUM=$(( 1 + 2 ))'
NUM=$(( 1 + 2 ))
echo ${NUM}
echo

echo 'Subtraction:  NUM=$(( 10 - 1 )) '
NUM=$(( 10 - 1 ))
echo ${NUM}
echo

echo 'Multiplication   use an asterick: NUM=$(( 2 * 4 ))'
NUM=$(( 2 * 4 ))
echo ${NUM}
echo

echo 'Division  - use a FORWARD Slash. NUM=$(( 6 / 2 ))'
NUM=$(( 6 / 2 ))
echo ${NUM}
echo

echo 'Division  - with float numbers BASH will only return whole values - it truncates the values to whole numbers.'
echo 'NUM=$(( 6 / 4 ))'
NUM=$(( 6 / 4 ))
echo "The correct number is 1.5   -   BASH will only return whole values - it truncates the values to whole numbers."
echo "   Therefore BASH does not support floating point values."
echo ${NUM}
echo
echo "If you need to work with numbers that contain decimals then you will need an external program like BC."
echo " BC stands for Basic Calculator"
echo

echo "Check to see if it is installed  type -a bc"
type -a bc
echo
echo 'bc -h  or --help because it is an installed program.'
bc -h
echo
echo "Therefore, to use floating point math you must use the -l option."
echo

echo 'To use BC  type echo ' 6 / 4 ' | bc -l '
echo  'You can use awk to do this... '

echo 'Modulo - the remainder function.'
echo  'echo 'NUM=$(( 6 % 4 ))''
echo ${NUM}
echo
echo "stopped notes at 6 minutes in video... maybe go back and finish these notes."
echo
echo " incrementing a number -   NUM=1;  (( NUM++ )) plus decrement, multiplication etc... "
echo
echo "Check out the let program      hell let    for more info  on operators..."
echo

echo "You can use expr command      type -a expr    "


echo
echo "arthimetic using variables."
echo 'DICE_A=3   DICE_B=2'
echo 'Total= $(( DICE_A + DICE_B))'
echo
echo  '(( NUM++ ))'
