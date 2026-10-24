#!/bin/bash

echo "The script name is : $0"

echo "The first argument is : $1"

echo "The second argument is : $2"

echo "The third argument is : $3"

echo "The get number of arguments given in command line is : $#"

echo "The all arguments given in command line is as a single word : $*"

echo "The all arguments given in command line is : $@"

echo "The process id of current shell is : $$"

echo "The process id of last command is : $!"

echo "The exit status of last command is : $?"

echo "The last background command is : $!"

wait $! 

SLEEP 10

#exit status 0 is success, anything above 0 is failure.
echo "The exit status of last command is : $?"

echo "total number of commands executed in current shell is : $LINENO"

echo "The current shell is : $SHELL"

echo "The current user is : $USER"

echo "The current working directory is : $PWD"

echo "The home directory of current user is : $HOME"

echo "The current shell level is : $SHLVL"

echo "The current terminal is : $TERM"

echo "The current path is : $PATH"

echo "The current language is : $LANG"

echo "The current host name is : $HOSTNAME"

echo "The current user id is : $UID"

echo "The current group id is : $GID"

echo "The current group name is : $GROUPS"

echo "The current user is : $LOGNAME"




