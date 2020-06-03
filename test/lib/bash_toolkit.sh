#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


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
