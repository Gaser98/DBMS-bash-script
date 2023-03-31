#!/bin/bash 
function createDB()
{
    if ! [[ -d ./DBMS ]]
        then
            mkdir DBMS
        fi
    echo "Please enter a database name"
    read name
    if [ -z $name ]
    then
        echo "Empty input,please enter a database name"
    createDB
    elif  [[ -d ./database/$name ]]
    then
        echo "Database already exists !"
        createDB
    else
        mkdir ./DBMS/$name
    fi
}