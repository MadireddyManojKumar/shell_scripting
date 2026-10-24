

#!/bin/bash
# =============================================================================
# Shell Special Variables - Quick Reference
# =============================================================================
 
# -----------------------------------------------------------------------------
# Positional and argument variables
# -----------------------------------------------------------------------------
# $0          - Name of the script (or shell) being run.
# $1 ... $9   - First through ninth arguments passed to the script or function.
# ${10} ...   - Arguments beyond the ninth (braces are required).
# $#          - Number of arguments passed.
# $*          - All arguments as one string; "$*" joins them with the first char of IFS.
# $@          - All arguments as separate words; "$@" keeps each argument intact.
 


echo "Allarguements given in command line is : ${1} ${2} ${3}  ...... "

echo "Allarguements given in command line is : $1 $2 $3  ...... ${10} ${11} "

echo "The get number of arguments given in command line is : $#"

echo "The all arguments given in command line is as a single word : $*"

echo "The all arguments given in command line is : $@"

# -----------------------------------------------------------------------------
# Process and status variables
# -----------------------------------------------------------------------------
# $?          - Exit status of the last command (0 = success, non-zero = failure).
# $$          - PID of the current shell (does not change in subshells).
# $!          - PID of the most recent background command.
# $-          - Option flags currently set in the shell (e.g., himBH).
# $_          - Last argument of the previous command.
# $PPID       - PID of the parent process.
# $UID        - Real user ID of the current user.
# $EUID       - Effective user ID of the current user (0 = root).


# dnf install -y bash-doc
#While executing the production grade script we need to know weather last command is successful or not,  if the last command executed successfully, then we get 0 as response, any nuber more than 0 is failure.

dnf install -y bash-doc
echo "The exit status of last command is : $?" # if we get 0 as response, then last command executed successfully, any number more than 0 is failure.

# In production we need to run commads with sudo access, to validate that we use $uid, if we get 0 as response, then we have sudo access, any number more than 0 is failure.        
echo "The current user id is : $UID" # if we get 0 as response, then we have sudo access, any number more than 0 is failure.

 
# -----------------------------------------------------------------------------
# Bash debugging and introspection
# -----------------------------------------------------------------------------
# $BASH_SOURCE    - Path of the current script file; works correctly in sourced files.
# $LINENO         - Current line number in the script.
# $FUNCNAME       - Name of the currently executing function (array = call stack).
# $PIPESTATUS     - Array of exit statuses for each command in the last pipeline.
# $BASHPID        - PID of the current Bash process; changes inside subshells.
# $BASH_SUBSHELL  - Subshell nesting level (0 in the main shell).
# $SHLVL          - How many shells deep you are; increments with each new Bash.
# $BASH_COMMAND   - Command currently executing; useful in trap ... ERR handlers.
# $BASH_LINENO    - Array of line numbers where each function in the stack was called.
# $BASH_ARGV      - Array of arguments for each call-stack frame (needs extdebug).
# $BASH_ARGC      - Array of argument counts for each call-stack frame (needs extdebug).
# $BASH_REMATCH   - Array of matches from the last [[ string =~ regex ]] test.
# $BASH_ENV       - File sourced before a non-interactive script runs.
# $BASH_ALIASES   - Associative array of currently defined aliases.
# $BASH_CMDS      - Associative array of hashed command paths.
# $BASH_VERSION   - Version of the running Bash.
# $SHELLOPTS      - Options currently enabled with set -o.
# $BASHOPTS       - Options currently enabled with shopt.


echo "The total number of commands executed in current shell is : $LINENO"
echo "The path of the current script file is : $BASH_SOURCE"
 
# -----------------------------------------------------------------------------
# Time and randomness
# -----------------------------------------------------------------------------
# $RANDOM         - Random integer between 0 and 32767.
# $SRANDOM        - 32-bit random number, more secure than $RANDOM (Bash 5.1+).
# $SECONDS        - Seconds elapsed since the shell or script started.
# $EPOCHSECONDS   - Current Unix timestamp in seconds (Bash 5.0+).
# $EPOCHREALTIME  - Unix timestamp with microsecond precision (Bash 5.0+).

#$( ... )   -> runs date and stores its output in the variable
# +%s        -> seconds since the Unix epoch (1970-01-01 00:00:00 UTC)
start=$(date +%s); sleep 2; end=$(date +%s); echo "Took $((end - start))s"



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

 
# -----------------------------------------------------------------------------
# System and user identification
# -----------------------------------------------------------------------------
# $HOSTNAME   - Name of the current host.
# $OSTYPE     - Operating system type (e.g., linux-gnu, darwin).
# $HOSTTYPE   - CPU architecture (e.g., x86_64).
# $MACHTYPE   - Full system type description (arch-vendor-os).
# $GROUPS     - Array of group IDs the current user belongs to.
# $USER       - Current username (set at login, not by Bash).
# $LOGNAME    - Login name of the current user.
# $HOME       - Current user's home directory.
# $SHELL      - User's default login shell (not necessarily the running shell).
 
# -----------------------------------------------------------------------------
# Paths and directories
# -----------------------------------------------------------------------------
# $PWD        - Current working directory.
# $OLDPWD     - Previous working directory (used by cd -).
# $PATH       - Colon-separated list of directories searched for commands.
# $CDPATH     - Directories cd searches when given a relative path.
# $DIRSTACK   - Array holding the directory stack used by pushd/popd.
# $TMPDIR     - Directory used for temporary files.
 
# -----------------------------------------------------------------------------
# Prompts and interactive behavior
# -----------------------------------------------------------------------------
# $PS1            - Main interactive prompt.
# $PS2            - Continuation prompt for multi-line input (default "> ").
# $PS3            - Prompt used by the select command.
# $PS4            - Prefix printed before each line with set -x (e.g., '+${LINENO}: ').
# $PROMPT_COMMAND - Command run just before each prompt is shown.
# $TMOUT          - Idle seconds before shell exits; also timeout for read/select.
# $COLUMNS        - Terminal width.
# $LINES          - Terminal height.
 
# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
# $HISTFILE        - File where command history is saved.
# $HISTSIZE        - Number of commands kept in memory.
# $HISTFILESIZE    - Number of commands kept in the history file.
# $HISTCONTROL     - Controls duplicates/space-prefixed entries (e.g., ignoreboth).
# $HISTTIMEFORMAT  - Adds timestamps to history output.
 
# -----------------------------------------------------------------------------
# Input, splitting, and built-in result holders
# -----------------------------------------------------------------------------
# $IFS        - Internal Field Separator; controls word splitting (space, tab, newline).
# $REPLY      - Default variable for read when no name is given.
# $OPTARG     - Argument of the current option being processed by getopts.
# $OPTIND     - Index of the next argument to be processed by getopts.
# $MAPFILE    - Default array filled by mapfile/readarray when no name is given.
# $COPROC     - Default array holding a coprocess's file descriptors.
# $COMP_WORDS - Array of words on the current command line (tab completion).
# $COMP_CWORD - Index of the word containing the cursor (tab completion).
# $COMPREPLY  - Array of completion results returned to Bash.
 
# -----------------------------------------------------------------------------
# Locale and environment
# -----------------------------------------------------------------------------
# $LANG       - Default locale setting.
# $LC_ALL     - Overrides all other locale settings.
# $TERM       - Terminal type, used by tput, clear, etc.
# $EDITOR     - Preferred text editor for programs like git and crontab.
# $VISUAL     - Preferred full-screen editor (checked before $EDITOR).
 
# -----------------------------------------------------------------------------
# Expansion tricks that act like special variables
# -----------------------------------------------------------------------------
# ${!#}       - Value of the last argument.
# ${@:2}      - All arguments from the second onward.
# ${#var}     - Length of a variable's value.
# ${#@}       - Same as $# (number of arguments).
 
