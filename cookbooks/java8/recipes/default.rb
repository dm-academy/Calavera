
###############################################################################
#############################    JAVA  8 ######################################
###############################################################################
#
# this is a "wrapper" cookbook. note the presence of an attributes file 

include_recipe "java::default"

#bash 'set Java environment' do
#  cwd '/opt'
#  code <<-EOH
#      ln -s /usr/lib/jvm/java-7-openjdk-amd64/bin/java /usr/bin/java
#      ln -s /usr/lib/jvm/java-7-openjdk-amd64/bin/jar /usr/bin/jar
#      ln -s /usr/lib/jvm/java-7-openjdk-amd64/bin/javac /usr/bin/javac
#      
#      echo export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 >> /etc/profile.d/java.sh
#      echo export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:'$PATH' >> /etc/profile.d/java.sh
#      echo export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 >> ~/.bashrc
#      echo export PATH=/usr/lib/jvm/java-7-openjdk-amd64/bin:'$PATH' >> ~/.bashrc
#      
#      chmod +x /etc/profile.d/java.sh
#      source /etc/profile.d/java.sh
#    EOH
#end


