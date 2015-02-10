# set up

group 'jenkins'

user 'jenkins' do
  group 'jenkins'
end


directory "/home/jenkins/.ssh"  do
  mode 00755
  action :create
  recursive true
end

execute 'duplicate keys' do
  cwd '/home/vagrant/.ssh'
  command 'cp * /home/jenkins/.ssh'   # includes authorized hosts
end

execute 'correct Jenkins directory ownership' do
  command ' chown -R jenkins /home/jenkins &&  \
            chgrp -R jenkins /home/jenkins'          
end

execute 'correct tomcat webapps permissions' do
  command   'chown -R jenkins /var/lib/tomcat6/webapps/* &&     \
             chgrp -R jenkins /var/lib/tomcat6/webapps/*'    #
end