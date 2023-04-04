#!/bin/bash

function createTable() {
    table_name=$1
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
    if [[ -f "${table_name}.txt" ]]; then
        echo "Table ${table_name} already exists"
        return
        createTable
    fi
    
    # Create table file
    touch "${table_name}.txt"

    # Add column names to file
    echo "$columns" > "${table_name}.txt"

    echo "Table ${table_name} created successfully"
}

