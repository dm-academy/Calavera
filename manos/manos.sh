#! /usr/bin/env bash
# Manos instance
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
###########################    BUILD APP     ##################################
###############################################################################

echo "initial build &, deploy, restart Tomcat..."
rm -rf /home/hijo
cp -rf /home/calavera/hijo /home # by doing this then it's no longer in the shared directory, preventing github backup
                                # Notice this did NOT copy .vagrant because it's hidden. Good thing.

cd /home/hijo
/usr/share/apache-ant-1.9.4/bin/ant   #
                                        # ./bin/ant not in path yet, I suppose I could fix this above
                                        # note that build is running as root
                                        
# need to update permissions once more after build
# otherwise non root will not be able to run build
chmod -R 777 /usr/share/apache-tomcat-8.0.15/ 
echo "point your browser at "
echo "http://localhost:8184/MainServlet"

# now to initialize git locally and remotely
# this means that manos script will be dependent on espina, but I guess that is fine
# after all this is supposed to be a complete system

###############################################################################
#############################    GIT    #######################################
###############################################################################
echo "installing git"
yum -y install git # assuming git is stable enough that yum is ok

# we'll see when we need these
# introduces the issue of security & identity within the sandbox
# git config --global user.name
# git config --global user.email

# generate key and get it over to espina. chicken and egg problem.
# perhaps should be generated outside of simulation
# at least, should ideally be generated on piernas
# ssh-keygen -t rsa -N "" -f ~/.ssh/id-rsa  # this generates a public key. but we pre-generated.
cp /mnt/public/id-rsa  ~/.ssh/
ssh-keyscan -H 192.168.33.13 >> ~/.ssh/known_hosts

cd /home/hijo           # just to be safe
mv /home/hijo/INTERNAL_gitignore /home/hijo/.gitignore #tricky. we cannot have this named .gitignore when
                                                        # it is under Github source control!
git init
git add .
git commit -m "initial commit"
#note that espina/hijo.git is ignored in GitHub .gitignore file
git remote add /home/hijo/espina.hijo ssh://root@192.168.33.13/home/calavera/hijo.git 
git push espina.hijo master

# git push espina.hijo master  #and... of course this won't work non-interactively.
# time to figure out keys. 

#...considered whether it would be more "idiomatic" to pull & build, but the problem is that I have to
# push from somewhere to the bare repo. so it really does start on manos.





