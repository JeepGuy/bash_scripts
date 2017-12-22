#!/bin/bash
[ -e /etc/shadow ]
echo "Password shadows are enabled."

echo "***********************"

[ -w etc/shadow ]

echo "You have permissions to edit /etc/shadow"

