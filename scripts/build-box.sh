#!/bin/bash -e

ROOT=$(git rev-parse --show-toplevel)

help() {
    cat <<EOF
Usage: ./$(basename $0)
Prerequisites: packer, vagrant, virtualbox and ansible have to be installed.

Description:
    This script takes the path of a pkrvars-file and builds a vagrant box using "$ROOT/template.pkr.hcl",
    "$ROOT/variables.pkr.hcl" and "$ROOT/plugins.pkr.hcl".

Arguments:
    PKR_VARS_FILE           Path of the pkrvars file to use.
    VAGRANT_SKIP_ADD        Toggle to skip "vagrant add box" for "vagrant_source_path" (optional).
                            Has to be set to "false", if the box in "vagrant_source_path" hasn't been downloaded before. 

Options:
    -h, --help    Show this help message and exit.

Examples:
    ./$(basename "$0") pkrvars/ubuntu-24.04.pkrvars.hcl
    ./$(basename "$0") pkrvars/ubuntu-24.04.pkrvars.hcl false

EOF
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    help
    exit 0
fi

if [ $# -eq 0 ]; then
    echo -e "🚨 ERROR: The 'PKR_VARS_FILE' argument is mandatory. \n"
    help
    exit 1
fi

if !packer version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "packer version". Is packer installed? \n"
  help
  exit 1
fi

if !vagrant --version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "vagrant --version". Is vagrant installed? \n"
  help
  exit 1
fi

if !vboxmanage --version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "vboxmanage --version". Is virtualbox installed? \n"
  help
  exit 1
fi

if !ansible --version > /dev/null 2>&1; then
  echo -e "🚨 ERROR: Cannot perform "ansible --version". Is ansible installed? \n"
  help
  exit 1
fi

PKR_VARS_FILE=$1
export VAGRANT_SKIP_ADD=${2:-"true"}

packer init .
packer fmt .
packer validate -var-file=$PKR_VARS_FILE .
packer build -var-file=$PKR_VARS_FILE .
