#! /usr/bin/env bash
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this build is for the espina project centered on Jenkins. 


###############################################################################
###########################  YUM UPDATE  ######################################
###############################################################################

# yum update
echo "updating with yum, be a few minutes..."
yum -y update

###############################################################################
#############################  JAVA  ##########################################
###############################################################################
echo "downloading Java, be a few minutes..." cd /
cd /usr/share
# not sure about the additional parameters here (e.g. --no-cookies),
# copied this syntax off the net but just using it here for Java
wget --no-cookies --no-check-certificate --header \
	"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; \
	oraclelicense=accept-securebackup-cookie" \
	"download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-i586.tar.gz" 

echo "installing Java..."
mv jdk-8u25-linux-i586.tar.gz* jdk-8u25-linux-i586.tar.gz
tar xvf jdk-8u25-linux-i586.tar.gz 

cd /usr/share/jdk1.8.0_25/

#alternatives --config java

# alternative to setting more path variables
alternatives --install /usr/bin/java java /usr/share/jdk1.8.0_25/bin/java 2
alternatives --install /usr/bin/jar jar /usr/share/jdk1.8.0_25/bin/jar 2
alternatives --install /usr/bin/javac javac /usr/share/jdk1.8.0_25/bin/javac 2
alternatives --set jar /usr/share/jdk1.8.0_25/bin/jar
alternatives --set javac /usr/share/jdk1.8.0_25/bin/javac
alternatives --set java /usr/share/jdk1.8.0_25/bin/java

rm -f /usr/share/jdk-8u25-linux-i586.tar.gz

echo "export JAVA_HOME=\"/usr/share/jdk1.8.0_25\"" >> /home/vagrant/.bashrc

###############################################################################
#############################  TOMCAT  ########################################
###############################################################################


# install apache tomcat
# doing this before some other stuff so that the server is solidly running
# before we attempt the Ant build that restarts it
cd /usr/share
echo "downloading & installing Tomcat..."

# Need to create Tomcat user & group, su & install

wget http://mirrors.koehn.com/apache/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz 
tar xzf apache-tomcat-8.0.15.tar.gz
rm -f apache-tomcat-8.0.15.tar.gz 
echo "export CATALINA_HOME=\"/usr/share/apache-tomcat-8.0.15\"" >> ~/.bashrc # leaving this as restricted to root





###############################################################################
#############################    GIT     ######################################
###############################################################################

echo "installing git"
yum -y install git # assuming git is stable enough that yum is ok

#init bare git repo for servlet app
#ok.. how do I do this. 
#the directory is /vagrant
#unless I specify otherwise
#the slave ... the same
# do I initialize the slave or the master first? 
# wrapper shell script at the calavera root level? 
# So, I cannot put the code into /espina that becomes /vagrant. 
# it will not then be a bare repository
# i have to initialize it from the manos instance
# so espina needs to exist first, with a bare repo
# then init manos, which checks into the bare repo
# what if espina is destroyed? what if manos is destroyed? going to have to 
# test both cases. This IS going to get complex. 
# default happy path: 
# espina exists
# bare repo inited 
# manos instantiated
# checks in software
# that kicks off jenkins
# which builds, tests, and deploys
# to the production environment
# which therefore also needs to exist first
# but how can it
# have to have a manual step in here somewhere
# or deploy compiled software
# wait - prod can exist 
# without anything deployed... 
# so order is
# instantiate empty prod ("corazon"?)
# instantiate espina
# instantiate manos
#   - push
#   - jenkins builds & deploys

###############################################################################
#############################    JENKINS     ##################################
###############################################################################
#reflecting recommendations from https://wiki.jenkins-ci.org/display/JENKINS/Tomcat

# sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
# sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
# yum -y install jenkins

echo "downloading & installing Jenkins..."
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
FIX THESE NEXT 2
export CATALINA_OPTS="-DJENKINS_HOME=/usr/share/apache-tomcat-8.0.15/ -Xmx512m"
echo "export CATALINA_OPTS=\"-DJENKINS_HOME=/usr/share/apache-tomcat-8.0.15/ -Xmx512m\"" >> ~/.bashrc 

cd /usr/share/apache-tomcat-8.0.15/webapps
rm -rf *
mv /usr/share/jenkins.war ./ROOT.war

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh


echo "Jenkins should now be available at http://localhost:8082"

