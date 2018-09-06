#!/bin/sh
my_message="hello darkeness my old friend"
MY_MESSAGE="I've come to talk with you again"
echo $my_message
echo $MY_MESSAGE


echo What is your name, please?
read MY_NAME
echo "Hello $MY_NAME my old friend."

# read undeclared variable will get the empty string

