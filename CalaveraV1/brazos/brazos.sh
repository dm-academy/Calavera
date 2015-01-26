#! /usr/bin/env bash
# Brazos instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this instance for the brazos project represents an automated central build instance



#network configuration (at this time, just localhosts for cluster)
source /mnt/public/netconf.sh

# generate ssh keys
source /mnt/public/ssh.sh

# Ant install
source /mnt/public/ant.sh

# JUnit install
source /mnt/public/junit.sh


###############################################################################
###########################    BUILD APP     ##################################
###############################################################################

mkdir /home/jenkins

# the initial build is initiated when manos pushes to espina and jenkins detects










