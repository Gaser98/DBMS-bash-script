#!/bin/bash 
function createDB()
{
    if ! [[ -d ./DBMS ]]
        then
            mkdir DBMS
        fi
    echo "Please enter a database name"
    read DBname
    if [ -z $DBname ]
    then
        echo "Empty input,please enter a database name"
    createDB
    elif  [[ -d ./DBMS/$DBname ]]
    then
        echo "Database already exists !"
        createDB
    else
        mkdir ./DBMS/$DBname
    fi
}
