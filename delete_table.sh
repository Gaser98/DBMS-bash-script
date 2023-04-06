#!/bin/bash
function deleteTable {
    #echo -e "Enter the name of the database the table is from : \c"
    #read DBname
    echo -e "Enter the name of the table you want to delete from : \c"
    read tname
    
        if [[ -f "${tname}.txt" ]]; then
            select item in "Drop table" "Delete table" "Exit"
            do 
                case $REPLY in
                    1)
                        rm ${tname}.txt
                        echo "The whole table has been deleted"
                        ;;
                    2)
                        awk 'NR==1{print > "temp.txt"; next} {exit}' ${tname}.txt && mv temp.txt ${tname}.txt
                        echo "Table has been cleared"
                        ;;
                    3) 
                        exit
                        tablesmenu
                        ;;
                esac 
            done
        else
            echo "There is no table with that name"
            tablesmenu
        fi
}
