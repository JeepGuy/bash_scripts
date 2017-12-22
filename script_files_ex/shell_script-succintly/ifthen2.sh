#!/bin/bash

echo " "
echo "---------------------"
echo " "

if [ "-w etc/shadow" ]

then 

   echo "You have permissions to edit /etc/shadow"

else 

   echo " You do NOT have permissions to edit /etc/shadow"

fi


echo " "
echo "---------------------"
echo " "

 # echo "You do not have permissions to edit /etc/shadow"


