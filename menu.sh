#!/bin/bash 
function menu()
{
        echo "Please select 1 to create a database"
        echo "Please select 2 to list databases"
        echo "Please select 3 to connect to a database"
        echo "Please select 4 to drop a database"
        echo "Please select 5 to exit"
        read op
        case $op in
                1) createDB
                        ;;
                2) listDB
                        ;;
                3) connectToDB
                        ;;
                4) dropDB
                        ;;
                5) exit
                        ;;
                *) echo "Please select a correct option"
        esac

}