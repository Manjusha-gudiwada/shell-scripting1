#!/bin/bash

read -p "enter some input: " input

if [ -z "$input" ]; then
echo "hey, you have not provided input"
exit 1
fi

if [ $input == "ABC" ]; then
echo "the input you have provided is ABC"

fi

echo "input = $input"
if [ $? -eq 0 ]; then
echo "success"
else
echo "not success"

fi