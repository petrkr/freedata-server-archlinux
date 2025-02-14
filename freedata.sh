#!/bin/bash

# Check to see if there is an old server running, and stop it if there is
checkoldserver=`ps auxw | grep FreeDATA | grep server.py`

if [ ! -z "$checkoldserver" ];
then
	oldserverpid=`echo $checkoldserver | cut -d" " -f2`
	echo "*************************************************************************"
	echo "Found old FreeDATA server at PID" $oldserverpid "- stopping it"
	echo "*************************************************************************"
	kill $oldserverpid
	sleep 7s
fi


if [ ! -d "$HOME/.config/FreeDATA" ];
then
	mkdir -p $HOME/.config/FreeDATA
fi
if [ ! -f "$HOME/.config/FreeDATA/config.ini" ];
then
	echo "*************************************************************************"
	echo "No config file found.  Copying example config file to"
	echo $HOME/.config/FreeDATA/config.ini
	echo "*************************************************************************"
	cp config.ini.example $HOME/.config/FreeDATA/config.ini
fi

# Run server

cd /opt/FreeDATA/

FREEDATA_CONFIG=$HOME/.config/FreeDATA/config.ini FREEDATA_DATABASE=$HOME/.config/FreeDATA/freedata-messages.db python3 ./freedata_server/server.py

