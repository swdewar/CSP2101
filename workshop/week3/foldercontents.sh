#/bin/bash

rtdir=~/CSP2101/

echo "AVAILABLE DIRECTORIES IN $rtdir:"
ls $rtdir

read -p 'Select a directory from the list above: ' seldir

    if [ "$(ls -A ${rtdir}${seldir})" ]; then
        #if there are files
        ls ${rtdir}${seldir}
    else
        echo "The $seldir directory is empty."
    fi