#!/bin/bash


# declaring function

sample()
{
    a=100
    echo "i am a function"
    echo "value of a in function is $a"
    b=20
    echo "First arg in function is $1"
}

# Accessing function

a=10
sample xyz
b=200
echo "value of b in main $b"

echo "First arg in main is $1"