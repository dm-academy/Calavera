
#artifactory
# get from http://bit.ly/Hqvfi9  (the zip file. use unzip.)

#create users


group 'artifactory'

user 'artifactory' do
  group 'artifactory'
end

remote_file "/opt/artifactory-latest.zip" do
  source "http://bit.ly/Hqv9aj"    # this was being stubborn with full URL for some reason. points to latest build. 
  mode '0755'
end

#cookbook_file 'artifactory-3.5.1.zip' do
#    path '/opt/artifactory-3.5.1.zip'
#    action :create
#end

execute 'unzip' do   # make idempotent
  user 'root'
  cwd '/opt'
  command 'jar -xvf /opt/artifactory-latest.zip && rm /opt/artifactory-latest.zip && mv /opt/artifactory* /opt/artifactory-latest'  # risky approach
end

execute 'correct artifactory directory permissions' do
  command 'chown -R artifactory /opt/artifactory-latest/ && chgrp -R artifactory /opt/artifactory-latest/'          # Chef does not have an easy way to do this.
end

execute 'correct executables' do
  command 'chmod 755 /opt/artifactory-latest/bin/*'       # Chef does not have an easy way to do this.
end

execute 'launch Artifactory' do
  user 'root'
  command '/opt/artifactory-latest/bin/artifactory.sh &'       # Start Artifactory. Need to install as a service that auto-restarts.  
end


# unzip to /opt (cd, chmod, etc)
