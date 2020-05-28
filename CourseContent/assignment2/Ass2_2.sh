#!/bin/bash
#Read Rectangle.txt into rectangleFile variable
rectangleFile=$(<rectangle.txt)
#Pipe text from rectangleFile line by line into a series of sed commands
# and Assign to outputText variable
#s/,*  */, /g       Substitute 0 or more ',' followed by 1 or 
#                   more spaces with ', '. Change is global.
#s/^/Name: /        Insert 'Name: ' at beginning of line.
#s/, /: Height: /   Substitute first ', ' with ': Height:'. 
#s/, /: Width: /    Substitute Second ', ' with ': Width:'.
#s/, [0-9]*//       Remove third ', ' followed by one or more digits.
#s/, /: Colour: /   Substitute fourth ', ' with ': Colour:'
#s/,//g             Remove remaining ',' if the line orignally 
#                   had trailing spaces. Change is global.
outputText=$( cat rectangle.txt | sed '
{ s/,* \+/, /g
s/^/Name: /
s/, /: Height: /
s/, /: Width: /
s/, [0-9]*//
s/, /: Colour: /
s/,//g
}')
#Display outputFile to screen
echo "$outputText"

