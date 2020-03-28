#! /bin/bash
read -p "What file would you like to read? " fileName
#if the file exists
if [[ -e "$fileName" ]]; then
    #if the file is readable
    if [[ -r "$fileName" ]]; then
        #read and print the contents of the file
        cat "$fileName"
    else
        #display error message
        echo "$fileName could not be read!"
    fi 
else
    #display error message
    echo "$fileName does not exist"
fi 
