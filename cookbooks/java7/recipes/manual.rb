
###############################################################################
#############################    JAVA  7 ######################################
###############################################################################
#


#remote_file "/mnt/public/jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz" do
#    source 'http://www.java.net/download/jdk7u40/archive/b40/binaries/jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz'
#end

directory '/usr/lib/jvm/'  do
    mode 00775
    action :create
    user "root"
    group "root"
    recursive true
end

cookbook_file 'jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz' do
    path '/usr/lib/jvm/jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz'
    user "root"
    group "root"
    action :create
end

execute 'unzip' do   # make idempotent
  cwd '/usr/lib/jvm'
  command 'tar -xvf jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz'  #not idemtpotent
end

link "/usr/bin/java" do
  to "/usr/lib/jvm/jdk1.7.0_40/bin/java"
end

link "/usr/bin/javac" do
  to "/usr/lib/jvm/jdk1.7.0_40/bin/javac"
end

link "/usr/bin/jar" do
  to "/usr/lib/jvm/jdk1.7.0_40/bin/jar"
end

execute 'unzip' do   # make idempotent
  cwd '/usr/lib/jvm'
  command 'tar -xvf jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz'  #not idempotent
end

execute 'env' do   # make idempotent
  command 'echo export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_40 >> /etc/profile.d/java.sh'  #not idempotent
end

execute 'env2' do   # make idempotent
  command 'echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_40 >> ~/.bashrc'  #not idempotent
end

execute 'env3' do   # make idempotent
  command 'chmod +x /etc/profile.d/java.sh'  #not idempotent
end

execute 'env4' do   # make idempotent
  command 'export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_40'  #not idempotent
end

#
## mkdir /usr/share/java
#cd /usr/share/java
#wget --quiet http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar
#wget --quiet http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
## for some reason these do not download cleanly, wind up named as full URL - ugh
#mv *junit-4.12.jar junit-4.12.jar
#mv *hamcrest-core-1.3.jar hamcrest-core-1.3.jar