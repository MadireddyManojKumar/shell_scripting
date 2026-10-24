#!/bin/bash

# Displaying different messages based on the time of the day using if-else statement.
time=$(date +%H)

if [ $time -lt 12 ]; then
    message="Good Morning $USER"
elif [ $time -lt 18 ]; then
    message="Good Afternoon $USER"
else
    message="Good Evening $USER"
fi

echo "$message"