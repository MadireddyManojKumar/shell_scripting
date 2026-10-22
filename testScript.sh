#!/usr/bin/env bash
# Use Bash and fail fast on errors, unset variables, and pipeline failures.
set -euo pipefail

# Get the script name for consistent log messages.
SCRIPT_NAME="$(basename "$0")"
LOG_PREFIX="[${SCRIPT_NAME}]"

# Print a log message with the script name as a prefix.
log() {
  printf '%s %s\n' "$LOG_PREFIX" "$*"
}

# Main execution flow of the script.
main() {
  # Standard messages to show when the script runs successfully.
  log "Test script executed without any issue."
  log "Test script executed successfully."
  log "Edited file in remote repo."

  # If arguments were passed, print them for demonstration.
  if [[ $# -gt 0 ]]; then
    log "Received arguments: $*"
  fi
}

# Run the main function and pass through any command-line arguments.
main "$@"
