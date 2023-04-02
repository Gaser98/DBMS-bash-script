#!/bin/bash
function dropDB()
{
        echo "Please enter a database name from below to delete it.. "
        ls ./DBMS
        read dbname
        if [ -z "$dbname" ]
        then
                echo "Empty input, Please try again"
                dropDB
        else
             rm -ir ./DBMS/$dbname  2> /dev/null
        fi
        if [[ $? == 0 ]]
        then
                echo "Database removed successfully.."
        else
                echo "Unexpected error"
        fi
        menu
}