###############################################################################
#############################  TOMCAT  ########################################
###############################################################################

# install apache tomcat

cd /usr/share
echo "downloading & installing Tomcat, ~ 2 minutes ..."

# Need to create Tomcat user & group, su & install

wget --quiet http://mirrors.koehn.com/apache/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz 
tar xzf apache-tomcat-8.0.15.tar.gz 1>/dev/null
rm -f apache-tomcat-8.0.15.tar.gz 
echo "export CATALINA_HOME=\"/usr/share/apache-tomcat-8.0.15\"" >> ~/.bashrc # leaving this as restricted to root

#start tomcat
/usr/share/apache-tomcat-8.0.15/bin/startup.sh