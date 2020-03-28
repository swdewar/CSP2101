#/bin/bash
#Prompt user for a folder, input on same line, store in variable "folderName"
read -p "Please enter a folder name to store your secret password:" folderName
#Create new folder named variable "folderName"
mkdir "$folderName"
#Prompt user for secret password, hide input, input on same line, store in variable "secretPassword"
read -sp "Please enter your secret password:" secretPassword
echo "$secretPassword" > ./"$folderName"/secret.txt
