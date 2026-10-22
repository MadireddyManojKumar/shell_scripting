# 🐚 Shell Scripting Special Variables — Cheat Sheet

A complete, practical reference of special variables in Bash/shell scripting, with notes on **where they're actually used in real-world scripts**.

---

## 📑 Table of Contents

- [Special Parameters (POSIX)](#-1-special-parameters-posix)
- [Bash-Specific Variables](#-2-bash-specific-variables)
  - [Script, Function & Debugging](#script-function--debugging)
  - [Exit Status & Process Info](#exit-status--process-info)
  - [Input, Parsing & Text](#input-parsing--text)
  - [Time & Random Numbers](#time--random-numbers)
  - [Shell & Version Info](#shell--version-info)
  - [Directory & Navigation](#directory--navigation)
  - [Prompts & History](#prompts--history-interactive-shells)
- [Common Environment Variables](#-3-common-environment-variables)
- [The 5 Variables 99% of Scripts Use](#-the-5-variables-99-of-scripts-use)
- [Real-World Examples](#-real-world-examples)
- [`"$@"` vs `"$*"`](#-vs--the-classic-interview-question)
- [References](#-references)

---

## 🔹 1. Special Parameters (POSIX)

These work in every POSIX shell (`sh`, `bash`, `zsh`, `dash`, `ksh`). They are set by the shell and are read-only.

| Variable | Meaning | Typical Real-World Use |
|---|---|---|
| `$0` | Name of the script or shell | Usage messages: `echo "Usage: $0 <env>"` |
| `$1`–`$9` | Positional arguments 1–9 | Reading inputs: `ENV=$1` |
| `${10}`+ | Arguments 10 and above (braces required) | Rare; `$10` means `$1` followed by `0` |
| `$#` | Number of arguments | Argument validation |
| `$@` | All arguments as separate words (when quoted) | Passing args through: `exec app "$@"` |
| `$*` | All arguments as one string (when quoted) | Logging all args on one line |
| `$?` | Exit status of the last command (`0` = success) | Error checking |
| `$$` | PID of the current shell | Unique temp/lock files: `/tmp/job.$$` |
| `$!` | PID of the last background process | Waiting on or killing background jobs |
| `$-` | Current shell option flags | Detect interactive shell: `[[ $- == *i* ]]` |
| `$_` | Last argument of the previous command | `mkdir -p /opt/app && cd $_` |

---

## 🔹 2. Bash-Specific Variables

### Script, Function & Debugging

| Variable | Meaning |
|---|---|
| `BASH_SOURCE` | Array of source file names in the call stack |
| `BASH_LINENO` | Array of line numbers where each function was called |
| `FUNCNAME` | Array of function names in the call stack |
| `LINENO` | Current line number in the script |
| `BASH_COMMAND` | Command currently executing (useful in `trap`) |
| `BASH_SUBSHELL` | Subshell nesting level |
| `SHLVL` | Shell nesting level |
| `BASH_ARGV` / `BASH_ARGC` | Argument stacks (with `shopt -s extdebug`) |
| `BASH_XTRACEFD` | File descriptor for `set -x` output |
| `PS4` | Prefix for `set -x` trace lines |

### Exit Status & Process Info

| Variable | Meaning |
|---|---|
| `PIPESTATUS` | Array of exit codes from the last pipeline |
| `BASHPID` | PID of current Bash process (differs from `$$` in subshells) |
| `PPID` | Parent process ID |
| `UID` / `EUID` | Real / effective user ID |
| `GROUPS` | Array of the user's group IDs |

### Input, Parsing & Text

| Variable | Meaning |
|---|---|
| `IFS` | Internal Field Separator (default: space, tab, newline) |
| `REPLY` | Default variable for `read` and `select` |
| `BASH_REMATCH` | Regex capture groups from `[[ str =~ regex ]]` |
| `OPTARG` | Current option's value in `getopts` |
| `OPTIND` | Index of the next argument for `getopts` |
| `OPTERR` | Whether `getopts` prints errors |
| `MAPFILE` | Default array for `mapfile` / `readarray` |
| `COPROC` | File descriptors of an unnamed coprocess |

### Time & Random Numbers

| Variable | Meaning |
|---|---|
| `SECONDS` | Seconds since the shell started |
| `RANDOM` | Random integer 0–32767 |
| `SRANDOM` | 32-bit random number (Bash 5.1+) |
| `EPOCHSECONDS` | Current Unix time (Bash 5.0+) |
| `EPOCHREALTIME` | Unix time with microseconds (Bash 5.0+) |
| `TMOUT` | Auto-logout / `read` timeout in seconds |

### Shell & Version Info

| Variable | Meaning |
|---|---|
| `BASH` | Path to the bash binary |
| `BASH_VERSION` | Version string |
| `BASH_VERSINFO` | Version as an array |
| `BASHOPTS` | Enabled `shopt` options |
| `SHELLOPTS` | Enabled `set -o` options |
| `HOSTTYPE` / `MACHTYPE` / `OSTYPE` | System / architecture info |
| `HOSTNAME` | Hostname |

### Directory & Navigation

| Variable | Meaning |
|---|---|
| `PWD` | Current directory |
| `OLDPWD` | Previous directory (used by `cd -`) |
| `DIRSTACK` | Directory stack (`pushd` / `popd`) |
| `CDPATH` | Search path for `cd` |

### Prompts & History (Interactive Shells)

| Variable | Meaning |
|---|---|
| `PS1` | Primary prompt |
| `PS2` | Continuation prompt (`>`) |
| `PS3` | Prompt for `select` menus |
| `PROMPT_COMMAND` | Command run before each prompt |
| `HISTFILE` / `HISTSIZE` / `HISTFILESIZE` | History file and size limits |
| `HISTCONTROL` / `HISTIGNORE` / `HISTTIMEFORMAT` | History behavior & formatting |
| `HISTCMD` | History number of the current command |

---

## 🔹 3. Common Environment Variables

Inherited from the environment, not shell-specific:

`HOME` · `PATH` · `USER` · `LOGNAME` · `SHELL` · `TERM` · `LANG` · `LC_*` · `TMPDIR` · `EDITOR` · `MAIL`

---

## ⭐ The 5 Variables 99% of Scripts Use

| # | Variable | Purpose |
|---|---|---|
| 1 | `$1`, `$2`… | Read inputs |
| 2 | `$#` | Validate that inputs were given |
| 3 | `"$@"` | Pass arguments through (wrappers, Docker `entrypoint.sh`) |
| 4 | `$?` | Check if the last command succeeded |
| 5 | `$0` | Usage / help messages |

```bash
#!/usr/bin/env bash
if [ $# -lt 1 ]; then
  echo "Usage: $0 <environment> [extra args]"
  exit 1
fi

ENV=$1
shift
./deploy.sh --env "$ENV" "$@"

if [ $? -ne 0 ]; then
  echo "Deploy to $ENV failed"
  exit 1
fi
```

---

## 🛠 Real-World Examples

**Find the script's own directory**
```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

**Report the failing line on error**
```bash
set -Eeuo pipefail
trap 'echo "Error on line $LINENO: $BASH_COMMAND" >&2' ERR
```

**Check every command in a pipeline**
```bash
curl -s "$URL" | jq '.status'
echo "curl exit: ${PIPESTATUS[0]}, jq exit: ${PIPESTATUS[1]}"
```

**Parse a CSV file**
```bash
while IFS=, read -r name age; do
  echo "$name is $age"
done < users.csv
```

**Run a background job and wait for it**
```bash
long_task &
pid=$!
wait "$pid"
echo "Task $pid exited with $?"
```

**Lock file using the shell's PID**
```bash
LOCK="/tmp/backup.$$.lock"
touch "$LOCK"
trap 'rm -f "$LOCK"' EXIT
```

**Parse options with `getopts`**
```bash
while getopts "e:v" opt; do
  case $opt in
    e) ENV=$OPTARG ;;
    v) VERBOSE=1 ;;
    *) echo "Usage: $0 [-e env] [-v]"; exit 1 ;;
  esac
done
shift $((OPTIND - 1))
```

**Regex capture groups**
```bash
if [[ "v2.14.3" =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  echo "Major: ${BASH_REMATCH[1]}"
fi
```

**Time a script**
```bash
SECONDS=0
./run_job.sh
echo "Completed in ${SECONDS}s"
```

**Retry with random jitter**
```bash
for i in {1..5}; do
  ./healthcheck.sh && break
  sleep $((RANDOM % 5 + 1))
done
```

---

## ❓ `"$@"` vs `"$*"` — The Classic Interview Question

Given arguments `"a b"` and `"c"`:

```bash
for x in "$@"; do echo "[$x]"; done   # [a b] [c]   → 2 words
for x in "$*"; do echo "[$x]"; done   # [a b c]     → 1 word
```

- `"$@"` preserves each argument exactly. **Use this almost always.**
- `"$*"` joins everything into one string using the first character of `IFS`.
- Unquoted `$@` and `$*` behave identically and break arguments containing spaces. **Always quote `"$@"`.**

---

## 📚 References

- `man bash` → sections **Special Parameters** and **Shell Variables**
- [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
- [POSIX Shell Command Language](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)

> Note: Variables like `SRANDOM`, `EPOCHSECONDS`, and `EPOCHREALTIME` require Bash 5.0+. Check your version with `echo $BASH_VERSION`.