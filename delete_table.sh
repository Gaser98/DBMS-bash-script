#!/usr/bin

#function to delete data from a table in database
function delete {
        echo -e "Enter the name of the database the table is from : \c"
	read DBname
	echo -e "Enter the name of the table you want to delete from : \c"
	read tname
	if [[ -d ./database/$DBname ]] then
	    if [[ -f ./database/$DBname/$tname ]] then
		     select item in "Delete the whole table" "Delete a field from the table" "Exit"
		do 
			case $REPLY in
				1)
					 > database/$tname
					 echo "The whole table has been deleted"
					 tablesmenu
					 ;;
				 2)
					 echo -e "Enter the name of the field you want to delete : \c"
					 read field 
					 awk `{$field=""; print$0}`
					 echo "Field has been deleted"
					 tablesmenu
					 ;;
				 3) exit
					 ;;
			 esac 
		done
	else
		echo "There is no table with that name"
		tablesmenu
		fi
		else 
		echo "There is no database with this name"
		tablesmenu
		fi
	}
