#!/bin/bash

function connectDB {
echo "Please enter the name of the database you want to connect :" 
read DBname

if [ -d $DBname ]; then
	cd ./BBMS/$DBname 2>>/dev/null
	echo "connected to $DBname successfully"
else
	echo "Database doesn't exist , enter a valid database "
	menu
fi
}
