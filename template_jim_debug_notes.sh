#!/bin/bash
# The above line is called shebang.
# Author: jcbrent
# Created Date: <yyy-mm-dd>
# Modified by: <Comma Delimited list>
#   < add to the Modified by list so we know who modified it last.
# <Replace with the description and/or purpose of this shell script.>
# ------------------------------------------------------------------------------------

Debugging notes:
BASIC called:  Print debugging aka tracing aka x-trace
-x prints commands and arguments as they executed
    means that instead of variables being displayed the values of those variables is displayed
    also trud for expansions wildcards are not displayed but what the expand to is displayed.
  add the -s option to the #!/bin/bash statement as in #!/bin/bash -x
  or inline use set -x to Set
     and set +x to stop...

-e = exit on error.
can be combined with other options at the shebang statement
-ex
-xe
-e -x
-x -e

-v = Prints shell input lines as they are read. BEFORE any substituions or expansions are applied.

help set will display info about options... pipe to less to scroll
as in help set | less


# Set Global Variables first  so they are always defined before being called.
#------------- Sample below
GLOBAL_VAR1="one"
GLOBAL_VAR2="two"


# Create Functions second - so they are read into the current bash session second
#------------- Sample below
function function_one() {
  local LOCAL_VAR1="one"
  # <Replace with function code.>
  echo "This script called the sample function (function_one) which does nothing (except print this line)."
}

echo " "
echo " Starting the \"XYZ/\" Script  - Named:  \"XYZ.sh "
echo " ----------------------------------------------------------------------------- "
echo " "
echo " Author:  Jim Brent "
echo " "
echo " <Print to the screen what the script does - change this line in the code>"
# Main body of the shell script starts here.
#
# <Replace with the main command comments of your shell script.>




# ------------------------------------------------------------------------------------
echo " "
echo " ----------------------------------------------------------------------------- "
echo " "
# ------------------------------------------------------------------------------------
# Exit with an explicit exit status last.
echo "Script ran successfully with an exit status of 0 (zero)."
echo " "
exit 0
