#!/bin/bash

#function to select a table from database 
function select {
	echo -e "Enter the name of the table you want to select from : \c"
	read tname
	if [[ -f ./DBMS/$tname ]] then
		select item in "Select the whole table" "Select a field from the table" "Exit"
		do
			case $REPLY in
				1)
					column -t -s ':' $tname 2>>/dev/null
					tablesmenu
					;;
				2) echo -e "Enter number of the column you want to select : \c"
					read num
					awk -F: '{print $num}' database/tname
					tablesmenu
					;;
				3) exit
					;;
			esac
		done
	else
		echo "Enter a valid table name"
				tablesmenu
}	
