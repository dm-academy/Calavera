#! /usr/bin/env bash
# Espina instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this build is for the espina project centered on Jenkins, which is the control & choreography instance (application level).

#network configuration (at this time, just localhosts for cluster)

ln -s /usr/lib/jvm/jdk1.8.0_25/bin/java /usr/bin/java #DELETE THESE WHEN ENVIRONMENT IS NEXT BAKED
ln -s /usr/lib/jvm/jdk1.8.0_25/bin/jar /usr/bin/jar
ln -s /usr/lib/jvm/jdk1.8.0_25/bin/javac /usr/bin/javac

rm -f espina.log

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
mkdir -p /home/jenkins/.ssh   # makes recursively
cp /mnt/public/keys/id_rsa*  /home/jenkins/.ssh/
cat /mnt/public/keys/id_rsa.pub >> /home/jenkins/.ssh/authorized_keys
chmod 700 /home/jenkins/.ssh


#### create tomcat env var
rm -rf /etc/profile.d/tomcat.sh
touch  /etc/profile.d/tomcat.sh
chmod 777 /etc/profile.d/tomcat.sh
echo "export CATALINA_OPTS=\"-DJENKINS_HOME=/home/jenkins -Xmx512m\"" >> /etc/profile.d/tomcat.sh
chmod 755 /etc/profile.d/tomcat.sh
source /etc/profile.d/tomcat.sh

cd /usr/share/apache-tomcat-8.0.15/webapps
rm -rf *
mv /usr/share/jenkins.war ./ROOT.war # this assumes Jenkins is only Tomcat app. 

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh
echo "waiting for Jenkins to initialize"
#sleep 90  # this was essential. Jenkins takes time to initialize & API call was failing

echo "Jenkins should now be available at http://localhost:8183"

# tomcat must be manually restarted on reboot (including vagrant halt) at this time

#now, configure brazos as slave... via Jenkins CLI
cd /usr/share/apache-tomcat-8.0.15/webapps/ROOT/WEB-INF/
#echo attempting to create slave brazos
# problem: we need to re-generate <credentialsId> 
# and then replace it in the slave xml def

#java -jar jenkins-cli.jar -s http://localhost:8080/ create-node brazos < /home/calavera/brazosSlave.xml #may not be idempotent

###############################################################################
#############################   PACKAGE REPO     ##############################
###############################################################################

# install artifactory
