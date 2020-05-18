#!/bin/bash

#CSP2101 Scripting Languages: Portfolio Task 2
#Simon Dewar
#937468

#If the file ./rectangle_f.txt exists, delete the file.
[ -f "./rectangle_f.txt" ] && rm "./rectangle_f.txt"
#List the available files in current directory and filter to those ending with .txt
echo "Available Files: "
ls | grep '\.txt$'
#Prompt user to enter one of the available text files to format.
read -p "Please enter the name of the available text file you would like to format: " file_name
#sed -e ...$file_name   Parse and format text from entered file line by line,
#                       with a series of commands written on separate lines.
#1d                     Delete line 1
#s/^/Name: /            Insert 'Name: ' at beginning of line.
#s/,/\tHeight: /        Substitute the first ',' with a tab space followed by 'Height:'. 
#s/,/\tWidth: /         Substitute the next ',' with a tab space followed by 'Width:'.
#s/,/\tArea: /          Substitute the next ',' with a tab space followed by 'Area:'.
#s/,/\tColour: /        Substitute the next ',' with a tab space followed by 'Colour:'.
#> rectangle_f.txt      Redirect output and save directly to a new text file.
sed -e '
1d
s/^/Name: /
s/,/\tHeight: /
s/,/\tWidth: /
s/,/\tArea: /
s/,/\tColour: /' $file_name > rectangle_f.txt