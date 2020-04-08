#!/bin/bash

#CSP2101 Scripting Languages: Portfolio Task 1
#Simon Dewar
#937468

#Welcome message suppress carriage feed
echo -n "Welcome to the guessage game. "
    


while true; do
    #begin outer loop while user agrees to play another game

    #Assign minimum and maximum ages to calculate the range of ages. (Tux, 2014)
    minage=20;
    maxage=70;
    range_age=$(($maxage-$minage+1)); 
    #random internal function assigns a random number from a range of 0-32767 to random_age (Tux, 2014)
    rand_age=$RANDOM;
    #A random number within the intended range is generated when rand_age is assigned the remainder of rand_age divided by range_age (Tux, 2014)
    rand_age=$(($rand_age%$range_age));
    #The random number is then adjusted to fall within the actual range by increasing the value of rand_age by minage. (Tux, 2014)
    rand_age=$(($rand_age+$minage));

    while true; do
        #Begin inner loop to repeat the following code until a correct guess is provided
        
        #Prompt for guess to be read into variable user_guess
        read -p 'Try to guess my age from 20 to 70 years old: ' user_guess
        
        #Test if input is an integer, , uses the regular expression comparison to test if all characters entered are withing the range of 0-9 (Henry-Stocker, 2013)
        if [[ "$user_guess" =~ ^[0-9]+$ ]]; then
            #Input is an integer
            if ! [ $user_guess -le $maxage -a $user_guess -ge $minage ]; then
                #If guess is not in the correct range, not(less than maxage and more than minage), 
                #Incorrect message, return to inner loop
                echo -n "Your guess is not in range. "
            else
                #Else guess is within correct range
                if [ $user_guess -lt $rand_age ]; then
                    #If guess is too low (less than rang_age), incorrect message, return to inner loop
                    echo -n "Your guess is too low. "
                else
                    #Else guess is not too low
                    if [ $user_guess -gt $rand_age ]; then
                        #If guess is too high (greater than rand_age), incorrect message, return to inner loop
                        echo -n "Your guess is too high. "
                    else
                        #Else guess is not too high, so guess is correct, success message, end inner loop    
                        echo "Congratulations! I am $user_guess years old."
                        break
                    fi   
                        #End if statement
                fi
                    #End if statement
            fi
                #End if statement
        else
            #Else user_guess is not an integer, incorrect message, suppress carriage feed
            echo -e -n "That is not a valid number. "
        fi
            #End if statement
    
    done
        #Repeat inner loop
    
    #Prompt user for single character input without requiring enter.
    read -n1 -p "Would you like to play again? Select Y for yes, any other key to quit: " play_again
    if [[ "$play_again" =~ ^[Yy]$ ]]; then
        #If user input is a Y or y, confirm choice on new line, return to outer loop
        echo -e "\nGreat, let's play again. "
    else
        #Else user input is not a Y or y, farewell message, end outer loop 
        echo -e "\nThanks for playing, try again another time."
        break
    fi

done
    #Repeat inner loop

exit 0
    #End script