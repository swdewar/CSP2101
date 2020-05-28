#!/bin/bash

#CSP2101 Scripting Languages: Assignment 3
#Simon Dewar
#937468

#Download url content to webpage.txt file.
curl https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 > webpage.txt
#Pipe all lines with a portion that matches the thumbnail path, strip all but the file name and save to file_names.txt.
sed -n '/https:\/\/secure\.ecu\.edu\.au\/service-centres\/MACSC\/gallery\/152\/DSC/ p' webpage.txt | sed -e '
s/^.*152\///
s/.jpg.*>$//' > file_names.txt
#cat file_names.txt
#Establish variables to be added to filenames during fetch commands.
thumbnail_url_prefix="https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/"
thumbnail_url_suffix=".jpg"
rtdir=$PWD

#Assign each line of the file_names.txt file to an array allowing for efficient indexing options.
while read line; do
    files_array+=($line)
done < file_names.txt

#Function to download and save to $rtdir/first parameter, the file specified by the second parameter
function download_thumbnail () {
    #If the file exists in the chosen directory, alert the user.
    if [ -f $rtdir/$1/$2$thumbnail_url_suffix ]; then
        echo -e "\n$2 has already been downloaded to the $1 directory.\n"
    #Or continue to download thumbnail.
    else
        #Download thumbnail based on name passed to function, to folder passed by function, create if it does not exist. Suppress terminal output (Ubuntu Manuals, 2019).
        wget -P $rtdir/$1 -q $thumbnail_url_prefix$2$thumbnail_url_suffix
        #Determine the file size in bytes and save to variable (SS64, n.d.).
        file_size=$(stat -c%s $rtdir/$1/$2$thumbnail_url_suffix)
        #If file size greater than 1 million bytes, output to screen progress including filename, file name with extension, size of file in MB.
        if [ $file_size -gt 1000000 ]; then        
            #Whole numbers and decimals calculated and displayed using division and modulo arithmetic.
            echo -e "\nDownloading $2, with the file name $2$thumbnail_url_suffix, with a file size of $((file_size / 1000000)).$(((file_size%1000000)/10000)) MB....File Download Complete\n" 
        #Or, if file size is less than 1 million bytes, output to screen progress including filename, file name with extension, size of file in KB.
        else 
            echo -e "\nDownloading $2, with the file name $2$thumbnail_url_suffix, with a file size of $((file_size / 1000)).$(((file_size%1000)/10)) KB....File Download Complete\n"
        fi
    fi
}

#Function to search for a given file name in text file and return index for use in array.
function file_index () {
    #Search for a given trailiing portion of filename in file_name.txt, show line number, pipe to sed to strip the string
    index_of_file=$(grep -n "$1$" file_names.txt | sed s/:.*$//)
    #As array indexes start at 0, must subtract 1. This also ensures the the variable is treated as numeric.
    index_of_file=$(($index_of_file-1))
}

#Function to search for and download a file specified by the user.
function specific_thumbnail () {
    #Search for the index of the given filename parameter using the file_index function.
    file_index $1
    #If index_of_file equals -1, then no matches were found in the file therfore the file does not exist.
    if [[ $index_of_file -eq -1 ]]; then
        echo "You entered $1. A file named DSC0$1 does not exist"
        #return a false status so loop will repeat.
        return 1   
    else 
        #The index generated is used to specify which file from files_array is downloaded to the Specific_Thumbnails folder by the download_thumbnail function.
        download_thumbnail Specific_Thumbnails ${files_array[$index_of_file]}        
    fi    
}

#Function to download all thumbnails.
function all_thumbnails () {
    #Each line of file_names.txt is used to download every file to the All_Thumbnails folder using the download_thumbnails function. 
    while read line; do
    download_thumbnail All_Thumbnails $line
    done < file_names.txt    
}

#Function to download a range of thumbnails between 2 file specified by the user.
function range_thumbnails () {
    #Takes the start and end of range indexes as the beginning end end values of a C style loop. 
    for ((i = $1; i <= $2; i++)); do
        #Indexes specify which files from files_array are downloaded to the Range_Thumbnails folder by the download_thumbnail function.
        download_thumbnail Range_Thumbnails ${files_array[$i]}
    done 
}

#Function to randomly choose an index based on a parameter indicating the number of elements in the array. 
function random_index () {
    #Random internal function assigns a random number from a range of 0-32767 to rand_number variable.
    rand_number=$RANDOM;
    #The remainder when rand_number is divided by the number of elements is then saved as the random index.
    rand_index=$(($rand_number%$1));
}

#Function to randomly select thumbnail files based on the number of files
function random_thumbnail () {
    #Files_array is duplicated for use within the function
    temp_array=(${files_array[@]})
    #Function will iterate the input number of times $1   
    for ((i = 0 ; i < $1 ; i++)); do
        echo "Random file number $(($i + 1)):"
        #The number of files (remaining) in the temporary array is passed to the random_index function.
        random_index ${#temp_array[@]}
        #The random index generated is used to specify which file from files_array is downloaded to the Random_Thumbnails folder by the download_thumbnail function.
        download_thumbnail Random_Thumbnails ${files_array[$rand_index]}
        #The selected filename is then removed from the array before the nect iteration to ensure it is not downloaded twice.
        unset temp_array[$rand_index]
        #echo ${#temp_array[@]}
    done
}

#Display program name.
echo -e "\nECU Thumbnail Downloader Program\n"
#Endless outer loop to allow user to continue the program.
while true; do
    #Output to screen a tan aligned list of choices to coincide with following case statement.
    echo -e "1.\tDownload a specific thumbnail.\n2.\tDownload all thumbnails.\n3.\tDownload a range of thumbnails.\n4.\tDownload a chosen number of random thumbnails.\n"
    #Prompt for input of choice and assign to selection variable used in following case statement.
    read -p "Please enter the number of your selection: " selection
    #Case statement takes selection variable and runs the commands that correspond with each number.
    case $selection in
        "1")
            #Output to screen instructions and a selection of file names stored in the files_array.
            echo -e "\nSelect one of the following available files to download:\n"
            echo -e "${files_array[@]}\n"
            #Begin endless loop to repeat until user enters a valid file name.
            while true; do 
                #Prompt user for input to be saved to chosen_file variable.
                read -p "Enter the last 4 digits of your chosen file: " chosen_file
                #Chosen_file is passed to specific_thumbnail function. The loop repeats until the function returns true.            
                if specific_thumbnail $chosen_file; then 
                break
                fi
            done;;
        "2")
            #Output to user confirmation of selection and call all_thumbnails function.
            echo "You have chosen to download all thumbnails."
            all_thumbnails;;
        "3")
            #Output to screen all available files from the array.
            echo -e "\nAvailable Files:\n${files_array[@]}"
            #Begin inner loop to repeat until valid input is provided.
            while true; do
                #Prompt user for start and end of range file_names and assign to variables.
                echo  -e "\nPlease select the start of the range from the available files above."
                read -p "Enter the last 4 digits: " start_range
                echo  "Please select the end of the range from the available files above."
                read -p "Enter the last 4 digits: " end_range
                #If files are in the correct order, use file_index fuction to determine index of start and end files..
                if [[ $start_range -lt $end_range ]]; then
                    file_index $start_range                    
                    start_index=$index_of_file
                    file_index $end_range                    
                    end_index=$index_of_file
                    #If start and end indexes are less than 0, they were not found. return to start of inner loop.
                    if [[ $start_index -lt 0 ]] || [[ $end_index -lt 0 ]]; then
                        echo "One of the files you entered does not exist."
                    #Or pass start and end indexes to range_thumbnails function and break out of inner loop.
                    else
                        range_thumbnails $start_index $end_index
                        break
                    fi
                else
                    #Or display error message and return to start of inner loop.
                    echo "The two files must be entered in order. Please try again."
                fi
            done;;
        "4")
            #Begin endless loop to repeat until valid input is achieved.
            while true; do
                #Prompt for user input with maximum number of files in array to be aqssigned to num_files variable.
                read -p "There are ${#files_array[@]} thumbnails, how many would you like to download? " num_files
                #If the number of files is greater than the number in the array, display error and return to start of inner loop.
                if [[ $num_files -gt ${#files_array[@]} ]]; then
                    echo "You have requested more than ${#files_array[@]} files. Please choose again."
                #Or pass num_files to random_thumbnails function and break out of inner loop.
                else
                    random_thumbnail $num_files
                    break
                fi
            done;;
         *)
            #Default case for all input that does not match other selections.
            echo "You have not made a valid choice, please try again."   
    esac
    
    #Prompt user for single character input without requiring enter.
    read -n1 -p "Would you like to select another option? Select Y for yes, any other key to quit: " again
    if [[ "$again" =~ ^[Yy]$ ]]; then
        #If user input is a Y or y, confirm choice on new line, return to start of outer loop
        echo -e "\n\n "
    else
        #Else user input is not a Y or y, termination message, break out of outer loop 
        echo -e "\nEnding Program.........\nProgram Complete!"
        break
    fi

done
rm $rtdir/file_names.txt
rm $rtdir/webpage.txt

#References

#SS64. (n.d.). stat. Retrieved from https://ss64.com/bash/stat.html

#Ubuntu Manuals. (2019). Wget - The non-interactive network downloader. 
#Retrieved from http://manpages.ubuntu.com/manpages/trusty/man1/wget.1.html#copyright