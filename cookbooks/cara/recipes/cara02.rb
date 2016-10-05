# final production build
# customizable by student - create your own caraXX.rb file and store it in the recipes directory.

remote_file "/var/lib/tomcat8/webapps/ROOT/WEB-INF/lib/CalaveraMain.jar" do
  source "http://espina1:8081/artifactory/simple/ext-release-local/hijo02/target/CalaveraMain.jar"
  mode '0755'
  #checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end

remote_file "/var/lib/tomcat8/webapps/ROOT/WEB-INF/web.xml" do
  source "http://espina1:8081/artifactory/simple/ext-release-local/hijo02/target/web.xml"
  mode '0755'
  #checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end

service "tomcat_ROOT" do
  action :restart
end
