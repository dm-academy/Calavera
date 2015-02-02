
###############################################################################
#############################    JUNIT   ######################################
###############################################################################
#
#execute echo "installing jUnit"
remote_file "/usr/lib/jvm/junit-4.12.jar" do
    source 'http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar'
end

remote_file "/usr/lib/jvm/hamcrest-core-1.3.jar" do
    source 'http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar'
end

link "/usr/bin/junit-4.12.jar" do
  to "/usr/lib/jvm/junit-4.12.jar"
end

link "/usr/bin/hamcrest-core-1.3.jar" do
  to "/usr/lib/jvm/hamcrest-core-1.3.jar"
end


#
## mkdir /usr/share/java
#cd /usr/share/java
#wget --quiet http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar
#wget --quiet http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
## for some reason these do not download cleanly, wind up named as full URL - ugh
#mv *junit-4.12.jar junit-4.12.jar
#mv *hamcrest-core-1.3.jar hamcrest-core-1.3.jar