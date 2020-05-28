#! /bin/bash
read -sn1 -p "1.  Create a folder
2.  List files in a folder
3.  Copy a folder
4.  Save a password
5.  Read a password
6.  Print newest file
" choice
case "$choice" in
1) ./foldermaker.sh;;
2) ./foldercontents.sh;;
3) ./foldercopier.sh;;
4) ./passwordFolder.sh;;
5) ,/readFile.sh;;
6) read -p "Type the files you would like to compare: " fileNames
    ./unlimitedFiles.sh $fileNames;;
esac