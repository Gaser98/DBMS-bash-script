#!/usr/bin/bash
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
                3) connectDB
                        ;;
                4) dropDB
                        ;;
                5) exit
                        ;;
                *) echo "Please select a correct option"
        esac

}
function createDB()
{
    if ! [[ -d ./DBMS ]]
        then
            mkdir DBMS
        fi
    echo "Please enter a database name"
    read DBname
    if [ -z "$DBname" ]
    then
        echo "Empty input,please enter a database name"
    createDB
    elif  [[ -d ./DBMS/$DBname ]]
    then
        echo "Database already exists !"
        menu
    else
        mkdir ./DBMS/$DBname
    fi
    menu
}
function listDB {
        cd ./DBMS
	ls -F | grep "/"
    menu
}
function connectDB {
echo "Please enter the name of the database you want to connect :" 
read DBname
cd ./DBMS/$DBname 2>>/dev/null
if [ $? -eq 0 ]; then
	echo "connected to $DBname successfully"
    tablesmenu
else
	echo "Database doesn't exist , enter a valid database "
	menu
fi
}
function dropDB()
{
        echo "Please enter a database name from below to delete it.. "
        #ls ./DBMS
        read DBname
        if [ -z "$DBname" ]
        then
                echo "Empty input, Please try again"
                dropDB
        else
             rm -ir ./DBMS/$DBname  2> /dev/null
        fi
        if [[ $? == 0 ]]
        then
                echo "Database removed successfully.."
        else
                echo "Unexpected error"
        fi
        menu
}
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

function createTable {
    echo -e "Enter table name : \c"
    read tname
    if [[ -f "${tname}.txt" ]]; then
        echo "Table ${tname} already exists"
        createTable
    else 
        touch "${tname}.txt"
        echo "Table ${tname} created successfully"
    fi
    echo -e "Enter columns : \c"
    read -a columns
    echo "${columns[*]}" | tr ' ' ':'

    # Check for null values in column names 
    for col in "${columns[@]}"; do
        if [ -z "$col" ]; then
            echo "Column names cannot be empty"
            exit 1
        fi
    done
    printf "%s\n" "${columns[@]}" > "${tname}.txt"
}


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
function updateTable {
    echo "Enter the table_name:"
    read tname

    echo "Enter the row:"
    read r

    echo "Enter the column number(s) you wish to modify:"
    read c

    echo "Enter the new data:"
    read new_data

    awk -v row="$r" -v columns="$c" -v new_data=$n \
    'BEGIN{FS=OFS=":"} 
    {
        split($0, fields, FS)
        if (NR == $r) {
            split($c, cols, ":")
            for (i in cols) {
                fields[cols[i]] = n
            }
        }
        for (i = 1; i <= NF; i++) {
            printf("%s%s", fields[i], (i == NF) ? "\n" : FS)
        }
    }' $tname.txt > temp.txt && mv temp.txt $tname.txt

    echo "Fields updated successfully!"
}

menu