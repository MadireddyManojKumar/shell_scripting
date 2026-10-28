#!/bin/bash

#$0  provides the name of the shell script.
script_name=${0}

# $1  provides the first argument passed to the shell script.
# EX: run the shell script with an arguement , like: sh 1.variables.sh "manojkumar"
#Now manojkumar will be read from the command as an argument and store the value in variable username_asArgument.
username_asArgument=${1}


# Since we already have script name in variable, we can reuse in multiple places.
echo "The script name is : $script_name" 

#Since we already have first argument stored in variable, we can reuse in multiple places.
echo "The first argument is : $username_asArgument"

# if we pass 1 auguement to command line, then $1 will get first arguement, $2 get the second arguement and $3 will get the third arguement. If we pass more than 3 arguements, then $4, $5, $6 and so on will get the respective arguements.
echo "Allarguements given in command line is : ${1} ${2} ${3}  ...... "


# up to 9 arguements can be accessed using $1, $2, $3, $4, $5, $6, $7, $8 and $9. If we pass more than 9 arguements, then we can access the arguements using ${10}, ${11} and so on. flower braces are used to access the arguements more than 9. If we don't use flower braces, then it will be considered as $1 and 0, which is not correct.
echo "Allarguements given in command line is : $1 $2 $3  ...... ${10} ${11} "

# $#  provides the number of arguments passed to the shell script command line. ex: sh 1.variables.sh "manojkumar" "manoj" "kumar".  output will be 3, since we passed 3 arguements to the command line.
echo "The get number of arguments given in command line is : $#"


#==================================
# Different types of variables
#   1. Local variables -- Used function scope, can be accessed only within the function.
#   2. Global variables -- Used script scope, can be accessed anywhere in the script.
#   3. Environment variables -- Used system scope, can be accessed by any process.
#   4. Special variables / Built in shell variables -- Have predefined meanings in the shell.
#    
#==================================


#Reading variables from user and caliculating area of rectangle using those variables.
echo "Enter the length of the rectangle:"
read length

echo "Enter the width of the rectangle:"
read width

area=$((length * width))

echo "The area of the rectangle is: $area"


