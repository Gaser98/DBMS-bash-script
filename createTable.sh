#!/bin/bash

function createTable() {
    tname=$1
    shift
    columns="$@"

    # Check for null values in column names 
    for col in "${columns[@]}"; do
        if [ -z "$col" ]; then
            echo "Column names cannot be empty"
            exit 1
        fi
    done
    # Check if table already exists
    if [[ -f "${tname}.txt" ]]; then
        echo "Table ${tname} already exists"
        return
        createTable
    fi
    
    # Create table file
    touch "${tname}.txt"

    # Add column names to file
    echo "$columns" > "${tname}.txt"

    echo "Table ${tname} created successfully"
    tablesmenu
}

