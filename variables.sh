#!/bin/bash

a=10

b=xyz

c=true

d=abc123

echo value of a is $a
echo value of b is ${b}

Date=$(date +%F)
echo date is $Date

Add=$((2+3))
echo addition is $Add

a1=100
a1=200
readonly a1
a1=300

echo $a1

echo value of Abc is $Abc

b2=(100 101.0 200 abc)
echo ${b2[0]}
echo ${b2[3]}

declare -A new=([class]=devops [trainer]=john [timing]=6am)
echo ${new[class]}
echo ${new[trainer]}