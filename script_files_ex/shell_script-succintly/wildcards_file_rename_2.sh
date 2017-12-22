#!/bin/bash
#
# Rename any file based on extension and with a prefix or the date
#!/bin/bash
#
# <Replace with the description and/or purpose of this shell script.>


# Set Global Variables first  so they are always defined before being called.
#-------------

GLOBAL_DATE=$(date +%F)   # % F is the format for yyy-mm-dd with no seconds...
GLOBAL_FILE_EXTENSION=""
GLOBAL_PREFIX=""

# Create Functions second - so they are read into the current bash session before being called
#------------- Sample below
function function_one() {
  local LOCAL_VAR1="one"
  # <Replace with function code.>
  echo "This script called the sample function (function_one) which does nothing (except print this line)."
}

# Main body of the shell script
#

echo " Starting the Wildcard File Rename Script  - wildcards_file_rename_2.sh"
echo " "

# Get Input from the user and decide what to do...
# echo " Enter in a file extension or press Enter for the current date which is: ${GLOBAL_DATE}"
echo " Please enter a file extension:"
read GLOBAL_FILE_EXTENSION
# echo ${GLOBAL_FILE_EXTENSION}

echo " "
read -p " Please enter a prefix (Press enter for the current date today is ${GLOBAL_DATE}):" GLOBAL_PREFIX
echo GLOBAL_PREFIX

# If condition to set the GLOBAL_FILE_EXTENSION to the date if no extension was entered.
if [ -z $GLOBAL_PREFIX ]
then

   GLOBAL_PREFIX=$GLOBAL_DATE
   echo " Prefix set to: ${GLOBAL_PREFIX}."
   echo ""
else

   echo " Prefix set to:  ${GLOBAL_PREFIX}"
   echo "--------------"
fi

# echo ${GLOBAL_PREFIX}
# echo ${GLOBAL_DATE}

for FILE in *.$GLOBAL_FILE_EXTENSION
do
    LOCAL_NEW_FILE="${GLOBAL_PREFIX}-${FILE}"
    echo "Renaming $FILE TO ${LOCAL_NEW_FILE}"
    mv ${FILE} ${LOCAL_NEW_FILE}
done

echo " "
echo "Script Completed correctly exit status 0 (zero)"

# ------------------------------------------------------------------------------------
echo " ----------------------------------------------------------------------------- "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Exiting script successfully with an exit status of 0 (zero)."
exit 0
