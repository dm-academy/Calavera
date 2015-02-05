
###############################################################################
#############################    JAVA  7 ######################################
###############################################################################
#
#execute echo "installing Java 7"
remote_file "/mnt/public/jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz" do
    source ''
end


cookbook_file 'jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz' do
    path '/usr/lib/jvm'
    user "root"
    group "root"
    action :create
end
 


#
## mkdir /usr/share/java
#cd /usr/share/java
#wget --quiet http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar
#wget --quiet http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
## for some reason these do not download cleanly, wind up named as full URL - ugh
#mv *junit-4.12.jar junit-4.12.jar
#mv *hamcrest-core-1.3.jar hamcrest-core-1.3.jar