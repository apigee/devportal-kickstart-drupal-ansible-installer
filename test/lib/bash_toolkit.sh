#!/bin/bash

###############################################################################
# Bash Toolkit: Useful functions for all scripts to use, such as output display.
###############################################################################

# ------------------------------------------------------------------------------
# Initialize script by creating log file, trapping errors, etc.
#
# Returns set variables:
#  SCRIPT_RUNDATE: The date for script running
#
script_initialize() {

  # Turn of case sensitive matching for our string compares
  shopt -s nocasematch

  # Set colors for displaying errors.
  export RED=$(tput setaf 1)
  export NORMAL=$(tput sgr0)

  # Set colors for displaying warnings.
  export YELLOW=$(tput setaf 3)

  # Get the date of script running
  export SCRIPT_RUNDATE="$(date '+%Y-%m-%d %H:%M:%S')"

}

# ------------------------------------------------------------------------------
# Display a dashed horizontal line.
#
# Example:
#   display_hr
#
display_hr() {
    display "--------------------------------------------------------------------------------"
}

# ------------------------------------------------------------------------------
# Display a major heading
#
# Parameters:
#   first: Message to display
#
# Example:
#   display_h1 "Starting Install"
#
display_h1() {
    display
    display_hr
    display $1
    display_hr
}

# ------------------------------------------------------------------------------
# Display error message to user in red.
#
# Parameters:
#   first: message to display
#
# Example:
#   display_error "Virus detected!"
#
display_error() {
  display "${RED}${1}${NORMAL}"
}

# ------------------------------------------------------------------------------
# Display messages
#   display "Hello World!"
display() {
  echo $@
}

display_nonewline() {
   printf -- "${@}"
}

display_multiline() {
   display_nonewline "${1?}\n"
}

# ------------------------------------------------------------------------------
# Display warn message to user in yellow.
#
# Parameters:
#   first: message to display
#
# Example:
#   display_warn "You left the oven on!"
#
display_warn() {
  display "${YELLOW}${1}${NORMAL}"
}
