#!/bin/bash
function tablesmenu()
{
        echo "Please select 1 to create a new table"
        echo "Please select 2 to list available tables"
        echo "Please select 3 to insert into a table"
        echo "Please select 4 to select from a table"
        echo "Please select 5 to delete from a table"
        echo "Please select 6 to update a table"
        echo "Please select 7 to exit"
        read op
        case $op in
                1)createTable
                        ;;
                2)ls .; tablesmenu
                        ;;
                3)insertIntoTable
                        ;;
                4)selectTable
                        ;;
                5)deleteTable #delete or drop table
                        ;;
                6)updateTable
                        ;;        
		7) exit
			;;
                *)echo "Invalid option..choose again"
                        ;;
        esac
        tablesmenu
}
