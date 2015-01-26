
###############################################################################
#############################  JAVA  ##########################################
###############################################################################
echo "downloading & installing Java, ~5 minutes ..." 
mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
# not sure about the additional parameters here (e.g. --no-cookies),
# copied this syntax off the net but just using it here for Java
# there are complications w/Oracle site otherwise (licensing clickthrough)

wget --quiet --no-cookies --no-check-certificate --header \
	"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; \
	oraclelicense=accept-securebackup-cookie" \
	"download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-i586.tar.gz" 

# sometimes this file downloads with junk appended. sometimes not.
# a warning on the mv sometimes therefore appears (that the files are the same)
echo "---disregard mv warning if it appears---"
mv jdk-8u25-linux-i586.tar.gz* jdk-8u25-linux-i586.tar.gz
tar xvf jdk-8u25-linux-i586.tar.gz 1>/dev/null
echo "---disregard mv warning if it appears---"

cd /usr/lib/jvm

ln -s /usr/lib/jvm/jdk1.8.0_25/bin/java /usr/bin/java
ln -s /usr/lib/jvm/jdk1.8.0_25/bin/jar /usr/bin/jar
ln -s /usr/lib/jvm/jdk1.8.0_25/bin/javac /usr/bin/javac

# alternative to setting more path variables 
#alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_25/bin/java 2
#alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.8.0_25/bin/jar 2
#alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_25/bin/javac 2
#alternatives --set jar /usr/lib/jvm/jdk1.8.0_25/bin/jar
#alternatives --set javac /usr/lib/jvm/jdk1.8.0_25/bin/javac
#alternatives --set java /usr/lib/jvm/jdk1.8.0_25/bin/java

rm -f /usr/lib/jvm/*.tar.gz

rm -rf /etc/profile.d/java.sh
echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25 >> /etc/profile.d/java.sh
echo export PATH=/usr/lib/jvm/jdk1.8.0_25/bin:'$PATH' >> /etc/profile.d/java.sh
echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25 >> ~/.bashrc
echo export PATH=/usr/lib/jvm/jdk1.8.0_25/bin:'$PATH' >> ~/.bashrc

chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh
#export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25 # this should have been taken care of by the one above, but tomcat install fails w/o
