#!/bin/bash
sed -e 's/,* \+/, /g; s/^/Name: /; s/, /: Height: /; s//: Width: /; s/, [0-9]*//; s/, /: Colour: /; s/,//g' rectangle.txt

echo ''
