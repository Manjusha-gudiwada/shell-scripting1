#!/bin/bash

echo hello world

echo -e "line1\nline2"

echo -e "word1\tword2"

echo -e "\e[31mredcolour"
echo -e "\e[32mgreencolour"

echo -e "\e[1;31mText in red colour"

echo -e "\e[1;33mtext in colour, to remove colour\e[0m"

echo no colour

# https://misc.flogisoft.com/bash/tip_colors_and_formatting