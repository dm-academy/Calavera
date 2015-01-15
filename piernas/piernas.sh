#! /usr/bin/env bash
# piernas instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this instance represents the infrastructure engineering instance and will host chef and perhaps an image store

#network configuration (at this time, just localhosts for cluster)
source /mnt/public/netconf.sh

# generate ssh keys
source /mnt/public/ssh.sh



# Git install
source /mnt/public/git.sh

