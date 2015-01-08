#! /usr/bin/env bash
# Cara instance
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

#Need a better approach. But better this than su'ing to root to build.
#Default install has Tomcat running as root. 
#Note chmod across Tomcat directory at bottom after build, that needs to be fixed as well

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh









