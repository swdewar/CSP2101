#/bin/bash

rtdir=~/CSP2101/

while true; do
    echo "AVAILABLE DIRECTORIES:"
    ls $rtdir
    read -p 'Enter a directory name from the list above: ' seldir

        if ! [ -d "${rtdir}${seldir}" ]; then
            echo "That directory does not exist. Please try again"
        else
            echo "You have selectyed the $seldir directory."
            break
        fi
done

#request for ne password
while true; do

    read -s -p 'Enter a new password for future use: ' selpw
        #If string is not null, zero length, string -z
        if ! [ -z "$selpw" ]; then
            echo "Thank you, Password accepted."
            break
        else
            echo "No password provided, please try again."
done

    if ! [ -f "${rtdir}${seldir}/secret.txt" ]; then   
        echo "The file secret.txt does not yet exist. Creating it now..."
        touch ${rtdir}${seldir}/secret.txt
        echo "Password now being written to file..."
        echo "$selpw" > "${rtdir}${seldir}/secret.txt"
        echo "Password has been written to ${rtdir}${seldir}/secret.txt"
        cat "${rtdir}${seldir}/secret.txt"
    else
        echo "The file secret.txt already exists. Password now being written to file..."
        echo "$selpw" > "${rtdir}${seldir}/secret.txt"
        echo "Password has been written to ${rtdir}${seldir}/secret.txt"
        cat "${rtdir}${seldir}/secret.txt"
    fi

exit 0