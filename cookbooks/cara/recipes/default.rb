# final production build

["/var/lib/tomcat6/webapps/ROOT/WEB-INF/",
 "/var/lib/tomcat6/webapps/ROOT/WEB-INF/lib"].each do | name |

  directory name  do
    mode 00755
    action :create
    recursive true
  end
end

remote_file "/var/lib/tomcat6/webapps/ROOT/WEB-INF/lib/CalaveraMain.jar" do
  source "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/CalaveraMain.jar"
  mode '0755'
  #checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end

remote_file "/var/lib/tomcat6/webapps/ROOT/WEB-INF/web.xml" do
  source "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/web.xml"
  mode '0755'
  #checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end


#execute 'env' do   # make idempotent
#  command 'echo export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64 >> /etc/profile.d/java.sh'  #not idempotent
#end
#
#execute 'env2' do   # make idempotent
#  command 'echo export JAVA_HOME=/usr/lib/java-6-openjdk-amd64 >> ~/.bashrc'  #not idempotent
#end
#
#execute 'env3' do   # make idempotent
#  command 'chmod +x /etc/profile.d/java.sh'  #not idempotent
#end
#
#execute 'env4' do   # make idempotent
#  command 'export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64'  #not idempotent
#end


service "tomcat6" do
  action :restart
end