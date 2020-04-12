#! /bin/bash
#If there are 3 files
if [ $# = 3 ]; then
    #if the arguments are all filenames
    if [ -f $1 -a -f $2 -a $3 ]; then
        #Initialise a newest variable
        newest=$1
        #Repeat until one file remains
        while [ $# -gt 1 ]; do
            #shift parameters left
            shift 
            #if file 1 is newer than newest, make newest equal file 1
            [ "$1" -nt "$newest" ] && newest=$1
        done
        #Read remaining newest file
        echo $newest
        exit 0
    else
        #Display filename error
        echo "At least one of the arguments is not a valid filename."
        exit 1
    fi
else
    echo "You have not entered the correct number of arguments."
    exit 1
fi
echo $?
exit 0
