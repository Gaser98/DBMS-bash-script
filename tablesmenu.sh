#!/bin/bash
function tablesmenu()
{
        echo "Please select 1 to create a new table"
        echo "Please select 2 to list available tables"
        echo "Please select 3 to drop a table"
        echo "Please select 4 to insert into a table"
        echo "Please select 5 to select from a table"
        echo "Please select 6 to delete from a table"
        read op
        case $op in
                1)createTable
                        ;;
                2)ls .; tablesmenu
                        ;;
                3)dropTable
                        ;;
                4)insertIntoTable
                        ;;
                5)selectFromtable
                        ;;
                6)deleteFromTable
                        ;;
		7) exit
			;;
                *)echo "Invalid option..choose again"
                        ;;
        esac
        tablesmenu
}