
###############################################################################
#############################  TOMCAT  ########################################
###############################################################################

# install & startapache tomcat
# dependent on Java - currently no check for this

cd /usr/share
echo "downloading, installing, starting Tomcat, ~ 2 minutes ..."

# Need to create Tomcat user & group, su & install

wget --quiet http://mirrors.koehn.com/apache/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz  #yes, this will change
tar xzf apache-tomcat-8.0.15.tar.gz 1>/dev/null
rm -f apache-tomcat-8.0.15.tar.gz

rm -rf /etc/profile.d/tomcat.sh
echo export CATALINA_HOME=/usr/share/apache-tomcat-8.0.15 >> /etc/profile.d/tomcat.sh
echo export CATALINA_HOME=/usr/share/apache-tomcat-8.0.15 >> ~/.bashrc 
# echo "/usr/share/apache-tomcat-8.0.15/bin/startup.sh" >> /etc/profile.d/tomcat.sh  #start tomcat on boot?
chmod +x /etc/profile.d/tomcat.sh
source /etc/profile.d/tomcat.sh

/usr/share/apache-tomcat-8.0.15/bin/startup.sh
        