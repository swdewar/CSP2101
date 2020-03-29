#! /bin/bash
#Initialise a newest variable to hold value of $1
newest=$1
#Repeat while 2 or more files remains
while [ $# -gt 1 ]; do
    if [ -f $1 ]; then
        #shift parameters left so that $1 drops off, $2 becomes $1 ...
        shift 
        #if file 1 is newer than newest, make newest equal file 1
        [ "$1" -nt "$newest" ] && newest=$1
    else
        #Display filename error
        echo "$1 is not a valid filename."
        exit 1
    fi
done
#Read remaining newest file
echo $newest
exit 0