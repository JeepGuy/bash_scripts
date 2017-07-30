/bash
# The above line is called shebang.
# Author: jcbrent
# Created Date: 30 July 2017
#
#  Give a tree view for those systems without Tree in BASH.
# ------------------------------------------------------------------------------------

echo " "
echo " Starting the \"CentOS 7 Tree view custom/\" Script  - Named:  \"jims_centos_7_tree.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " Author:  Jim Brent "
echo " "
echo " A custom directory viewer for CentOS 7 from the current directory."
# Main body of the shell script starts here.
#
# <Replace with the main command comments of your shell script.>

shopt -s globstar
for file in **/*
do
    slash=${file//[^\/]}
    case "${#slash}" in
        0) echo "|-- ${file}";;
        1) echo "|   |--  ${file}";;
        2) echo "|   |   |--  ${file}";;
    esac
done

# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
