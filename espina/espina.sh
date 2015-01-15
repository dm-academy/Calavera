#! /usr/bin/env bash
# Espina instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this build is for the espina project centered on Jenkins, which is the control & choreography instance (application level).

#network configuration (at this time, just localhosts for cluster)
source /mnt/public/netconf.sh

# generate ssh keys
source /mnt/public/ssh.sh


# Git install
source /mnt/public/git.sh

###############################################################################
############################ INITIALIZE GIT ###################################
##############################################################################
# from http://git-scm.com/book/it/v2/Git-on-the-Server-Setting-Up-the-Server

cp /mnt/public/keys/id_rsa*  /home/vagrant/.ssh/
cat /mnt/public/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# need to init bare repo
# project directory is /home/calavera
cd /home/calavera
rm -rf hijo.git   # in case it is already there from previous shared directory interactions
mkdir hijo.git
cd hijo.git
git --bare init


###############################################################################
#############################    JENKINS     ##################################
###############################################################################
#reflecting recommendations from https://wiki.jenkins-ci.org/display/JENKINS/Tomcat

cd /usr/share   
echo "downloading & installing Jenkins..."
wget --quiet http://mirrors.jenkins-ci.org/war/latest/jenkins.war

#### create tomcat env var
rm -rf /etc/profile.d/tomcat.sh
touch  /etc/profile.d/tomcat.sh
chmod 777 /etc/profile.d/tomcat.sh
echo "export CATALINA_OPTS=\"-DJENKINS_HOME=/usr/share/apache-tomcat-8.0.15/ -Xmx512m\"" >> /etc/profile.d/tomcat.sh
chmod 755 /etc/profile.d/tomcat.sh
source /etc/profile.d/tomcat.sh

cd /usr/share/apache-tomcat-8.0.15/webapps
rm -rf *
mv /usr/share/jenkins.war ./ROOT.war

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh
echo "Jenkins should now be available at http://localhost:8183"

#now, configure brazos as slave... via Jenkins CLI

###############################################################################
#############################   PACKAGE REPO     ##############################
###############################################################################
