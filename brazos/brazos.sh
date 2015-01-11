#! /usr/bin/env bash
# Brazos instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this instance for the manos project represents an end developer instance, with:
#   Java
#   ant
#   junit
#   git
#   tomcat

#   Todo: it should download the skeleton Java/Tomcat project, and do an initial build.

# Yum update
#source /mnt/public/yum.sh

# Java install
#source /mnt/public/java.sh

# Tomcat install
#source /mnt/public/tomcat.sh

# Ant install
source /mnt/public/ant.sh

# JUnit install
source /mnt/public/junit.sh


###############################################################################
###########################    BUILD APP     ##################################
###############################################################################

mkdir /home/jenkins

# the initial build is initiated when manos pushes to espina and jenkins detects










