#!/bin/bash -e

PKRVARS_FILE="pkrvars/ubuntu-22.04.pkrvars.hcl"

packer fmt .
packer validate -var-file=$PKRVARS_FILE .
packer build -var-file=$PKRVARS_FILE .
