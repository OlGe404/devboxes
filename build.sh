#!/bin/bash -e 

packer validate .
packer build .
