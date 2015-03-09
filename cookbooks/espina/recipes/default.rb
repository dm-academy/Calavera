
#artifactory
# get from http://bit.ly/Hqvfi9  (the zip file. use unzip.)

#create users


group 'artifactory'

user 'artifactory' do
  group 'artifactory'
end

remote_file "/opt/artifactory-3.5.2.1.zip" do
  source "http://bit.ly/Hqv9aj"    # this was being stubborn for some reason
  mode '0755'
end

#cookbook_file 'artifactory-3.5.1.zip' do
#    path '/opt/artifactory-3.5.1.zip'
#    action :create
#end

execute 'unzip' do   # make idempotent
  user 'root'
  cwd '/opt'
  command 'jar -xvf /opt/artifactory-3.5.2.1.zip'
end


execute 'correct artifactory directory permissions' do
  command 'chown -R artifactory /opt/artifactory-3.5.2.1/ && chgrp -R artifactory /opt/artifactory-3.5.2.1/'          # Chef does not have an easy way to do this.
end

execute 'correct executables' do
  command 'chmod 755 /opt/artifactory-3.5.2.1/bin/*'       # Chef does not have an easy way to do this.
end

execute 'launch Artifactory' do
  user 'root'
  command '/opt/artifactory-3.5.2.1/bin/artifactory.sh &'       # Start Artifactory. Need to install as a service that auto-restarts.  
end


# unzip to /opt (cd, chmod, etc)
