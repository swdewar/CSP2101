#! /bin/bash

#if the arguments are all filenames
if [ -f $1 -a -f $2 -a $3 ]; then
    #Initialise a newest variable to hold value of $1
    newest=$1
    #Repeat while 2 or more files remains
    while [ $# -gt 1 ]; do
        #shift parameters left so that $1 drops off, $2 becomes $1 ...
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
    exit1
fi

exit 0
