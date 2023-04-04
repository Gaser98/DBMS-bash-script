#!/bin/bash
function updateTable (){

echo "Enter the table_name:"
read tname

echo "Enter the row number:"
read row

echo "Enter the column number(s) you wish to modify:"
read columns

echo "Enter the new data:"
read new_data

awk -v row="$row" -v columns="$columns" -v new_data="$new_data" 'BEGIN {FS=OFS="\t"} NR==row {split(columns, c, ":"); for (i in c) $c[i] = new_data} {print}' $tname.txt > tmp && mv tmp $tname.txt

echo "Fields updated successfully!"
}
