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
