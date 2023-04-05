#!/bin/bash

#funcion to get only files in the DB
function listDB {
        cd ./DBMS
	ls -F | grep "/"
	tablesmenu
}

