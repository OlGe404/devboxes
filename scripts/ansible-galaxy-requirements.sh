#!/bin/bash -e

ROOT=$(git rev-parse --show-toplevel)

help() {
    cat <<EOF
Usage: ./$(basename "$0")
Prerequisites: ansible and ansible-galaxy have to be installed.

Description:
  Installs the ansible-galaxy requirements from the "$ROOT/requirements.yaml" file.

  If a virtualenv for python3 exists at "$ROOT/.venv/bin/activate", it is used.

Options:
  -h, --help    Show this help message and exit.

EOF
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    help
    exit 0
fi

if [ -d "$ROOT/.venv" ]; then
    source "$ROOT/.venv/bin/activate"
fi

if ! ansible --version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "ansible --version". Is ansible installed? \n"
  help
  exit 1
fi

if ! ansible-galaxy --version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "ansible-galaxy --version". Is ansible-galaxy installed? \n"
  help
  exit 1
fi

ansible-galaxy collection install --force --requirements-file "$ROOT/requirements.yaml" 
