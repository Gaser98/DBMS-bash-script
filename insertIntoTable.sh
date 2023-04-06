#!/bin/bash
function insertIntoTable {
    # Get the name of the table
    echo -e "Enter the name of the table to populate: \c"
    read tname

    # Check if the table exists
     if [[ ! -f ${tname}.txt ]]; then
        echo "Table ${tname}.txt does not exist."
        return 1
    fi
    pwd
    # Get the list of column names
    column_names=($(head -n 1 ${tname}.txt | tr ':' ' '))

    # Loop through each column and prompt for values
    i=0
    for column_name in "${column_names[@]}"; do
        # Check if the column is the primary key
        if [[ "$column_name" == ":id:" ]]; then
            # Check if the id column is already populated
            if grep -q ":$id:" ${tname}.txt; then
                echo "The id column of table ${tname}.txt is already populated."
                continue
            fi
        fi

        # Prompt for column value
        echo -e "Enter a value for column $column_name: \c"
        read column_value

        # Check if the column value is null
        if [[ -z $column_value ]]; then
            echo "Column $column_name cannot be null."
            continue
        fi

        # Check if the column value already exists (for non-id columns)
        if [[ "$column_name" != "id" ]]; then
            if grep -q ";$column_value;" $tname.txt; then
                echo "Column $column_name value must be unique."
                continue
            fi
        fi

        # Append the column value to the table file
        #echo -e "$column_value" >> $tname.txt 
        arr[$i]=$column_value
        echo ${arr[$i]}
        i=$((i+1))
        echo $i
        #printf "%s\n" "${columns[@]}" > "${tname}"
        echo "Column $column_name value '$column_value' added to table $tname.txt"
    done
    echo "${arr[*]}" | tr ' ' ':' >> "${tname}.txt"
   #printf "%s\n" "${arr[@]}" >> "${tname}.txt"
}
