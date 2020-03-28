#/bin/bash
# Prompt for folder name, input on same line saved to variable "foldername"
read -p "Please enter the folder to display contents:" folderName
# Display folder contents of stored variable "folderName"
ls $folderName
