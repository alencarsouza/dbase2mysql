#!/bin/bash -e
#
# dbase2mysql - Migrate DBF files to MySql database
#
# Copyright (c) 2012 Junior Holowka <junior.holowka@gmail.com>
#
# HOWTO: ./dbase2mysql.sh - This script must be run at the same *.dbf directory
#

HOST="localhost"
USER="root"
PASS="pass"
BASE="database"

# check if dbf2mysql package is installed
if [ -e /usr/bin/dbf2mysql ]
then
	echo "dbf2mysql already installed!"
else
	echo "dbf2mysql being installed..."
	sudo apt-get install --yes --force-yes dbf2mysql
fi

# list files with *.dbf extension
for FILENAME in $(ls -tr *.dbf | sed 's/ /__/g')
do
 	FILENAME="$(echo $FILENAME | sed 's/__/ /g')"
	FILEXTEN="$(echo $FILENAME | sed 's/\..\{3\}$//')"

	echo -e "\033[1m===> Migrating $FILENAME to $HOST>$BASE>$FILEXTEN ... \033[0m\n"
	dbf2mysql -h $HOST -P $PASS -U $USER -d $BASE -t $FILEXTEN -c $FILENAME

done
exit 0
