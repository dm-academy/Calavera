#! /bin/bash

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update
sudo apt-get -y install jenkins

echo "go vagrant ssh and sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo "for some reason can't see this from initial provisoning"
echo "go to web interface now and configure Jenkins"
