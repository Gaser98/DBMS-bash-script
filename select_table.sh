#!/bin/bash
function selectTable {
    echo -e "Enter the name of the table you want to select from : \c"
    read tname
    pwd
    if [[ -f ${tname}.txt ]]; then
        cat ${tname}.txt
    else
        echo "Error displaying table ${tname}.txt"
    fi
    tablesmenu
}
