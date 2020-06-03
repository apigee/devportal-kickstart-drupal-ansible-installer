#!/usr/bin/env bash

###############################################################################
# run-tests.sh - Run tests on a Docker instance
###############################################################################

# -----------------------------------------------------
# CONSTANTS
# -----------------------------------------------------

# Default port
HOST_PORT="9090"
OS_NAME=""
# -----------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------

# Help function
display_help() {
  cat <<EOF

Run tests on a specific Docker OS.

Usage: run-bats-on-docker.sh [OPTIONS] -- <tests>

The tests passed in should be the path relative to the tests/testcases
directory.

Options:
  -h  Display this help message
  -o  Operating system to use, defaults to '${OS_NAME}'. Valid values
      are: centos7,centos8,rhel8

Examples:
  ./run-tests-on-docker.sh -h                        Display this help message
  ./run-tests-on-docker.sh -o centos8 install.bats   Run install.bats on CentOS
                                                     8 operating system

EOF
}


# -----------------------------------------------------
# Initialize Script
# -----------------------------------------------------

# http://redsymbol.net/articles/unofficial-bash-strict-mode/

# Immediately exit if any command has non zero exit status.
set -e
# Immediately exit if an undeclared variable is used.
set -u
# If any command in a pipeline fails, use that code for the exit status
# of the pipeline instead of just the exit status of the last command
set -o pipefail

# Get directory this script is running in and put it in SCRIPT_PATH
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do
  # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" && pwd)"
  source="$(readlink "$source")"
  # if $SOURCE was a relative symlink, we need to resolve it relative to the
  # path where the symlink file was located
  [[ $source != /* ]] && source="$DIR/$source"
done
SCRIPT_DIR="$(cd -P "$(dirname "$source")" && pwd)"

# Load function library
# shellcheck source=amp-install-scripts/lib/bash_toolkit.sh
source "${SCRIPT_DIR}"/lib/bash_toolkit.sh

# Create log file, setup traps for errors, etc.
script_initialize

# -----------------------------------------------------
# Main
# -----------------------------------------------------

while getopts "ho:p:" opt; do
  case ${opt} in
  h) # process option h
    display_help
    exit 0
    ;;
  o) # What OS
    OS_NAME=$OPTARG
    ;;
  p) # What port on host should Docker use
    HOST_PORT=$OPTARG
    ;;
  \?)
    display_error "Invalid option."
    display_help
    exit 1
    ;;
  esac
done

# Validate OS_NAME is set
if [ "$OS_NAME" == "" ]; then
  display_error "ERROR: No operating system passed in with -o option."
  display "Run $0 with -h for help."
  exit 1
fi

# Remove command line arguments so that $1 should now be params after "--"
shift $(($OPTIND -1))

## $1 is the test to run, add proper path to it to run on Docker
#TEST_PATH=/opt/devportal-kickstart-project-composer/amp-install-scripts/test/testcases/"${1}"

display_h1 "Test runner"
display "$SCRIPT_RUNDATE"
display "OS: $OS_NAME"
display_hr

# Syntax check the playbook
display_h1 "Validating playbook syntax"
cd "${SCRIPT_DIR}"/..
ansible-playbook "${SCRIPT_DIR}"/../playbook.yml --syntax-check

# Install dependencies.
display_h1 "Updating galaxy roles"
ansible-galaxy install -r requirements.yml

# do a docker build
display_h1 "Running docker build"
cd "${SCRIPT_DIR}"/..
docker build -f ${SCRIPT_DIR}/dockerfiles/"${OS_NAME}".Dockerfile -t ks-"${OS_NAME}" .

display_h1 "Running docker commands"

# Run full functional install test
set -x
#docker run -t --rm -p ${HOST_PORT}:80 --name ks-"${OS_NAME}" ks-"${OS_NAME}"  "$TEST_PATH"
docker run --detach -p ${HOST_PORT}:80 --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --name ks-"${OS_NAME}" ks-"${OS_NAME}"

docker exec --workdir /opt/kickstart-ansible --tty ks-centos8 env TERM=xterm ansible-playbook /opt/kickstart-ansible/playbook.yml