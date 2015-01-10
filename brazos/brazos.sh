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

echo "export JAVA_HOME=\"/usr/share/jdk1.8.0_25\"" >> ~/.bashrc

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

#Need a better approach. But better this than su'ing to root to build.
#Default install has Tomcat running as root. 
#Note chmod across Tomcat directory at bottom after build, that needs to be fixed as well

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh

###############################################################################
#############################    ANT   ########################################
###############################################################################

#install ant
echo "installing Ant..."
#yum -y install ant   # Yum install of ant was not working correctly. outdated & other issues.
cd /usr/share
wget http://mirror.nexcess.net/apache//ant/binaries/apache-ant-1.9.4-bin.tar.gz
tar xzf apache-ant-1.9.4-bin.tar.gz
rm -f apache-ant-1.9.4-bin.tar.gz

# tried to put these in /etc/profile.d but 1) didn't work for "non-login shells"
# (even shells I was logging in with) and 2) found advice against it
echo "export ANT_HOME=\"/usr/share/apache-ant-1.9.4\"" >> ~/.bashrc
echo "export PATH=\"/usr/share/apache-ant-1.9.4/bin:\"$PATH" >> ~/.bashrc

###############################################################################
#############################    JUNIT   ######################################
###############################################################################

echo "installing jUnit"
# yum -y install junit # Yum install again outdated

mkdir /usr/share/java
cd /usr/share/java
wget http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar
wget http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
# for some reason these do not download cleanly, wind up named as full URL - ugh
mv *junit-4.12.jar junit-4.12.jar
mv *hamcrest-core-1.3.jar hamcrest-core-1.3.jar

###############################################################################
#############################    GIT     ######################################
###############################################################################

echo "installing git"
yum -y install git # assuming git is stable enough that yum is ok


###############################################################################
###########################    BUILD APP     ##################################
###############################################################################

mkdir /home/jenkins

# the initial build is initiated when manos pushes to espina and jenkins detects










