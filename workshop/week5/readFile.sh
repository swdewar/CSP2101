#! /bin/bash
read -p "What file would you like to read? " fileName
    for i in $( find ~/CSP2101 -name $fileName\* ); do
       #if the file exists and ther's something in there -s
        if [ -s "$i" ]; then
            echo "The contents of the $i file are as follows:"
            cat "$i"        
        else           
            echo "The $i file is empty."
        fi
    done 
exit 0