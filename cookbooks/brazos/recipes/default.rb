# brazos default
# set up remote slave build server

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
  command 'cp /mnt/shared/keys/* /home/jenkins/.ssh'  # this should be the source - fixes part of problem
end

execute 'authorize jenkins public key' do
  cwd '/home/jenkins/.ssh'
  command 'cat id_rsa.pub >> authorized_keys'   # includes authorized hosts
end

execute 'correct Jenkins directory ownership' do
  command ' chown -R jenkins /home/jenkins &&  \
            chgrp -R jenkins /home/jenkins'
end


# when rebuilding brazos it would be nice to let Jenkins know, if Jenkins is running.
# slave relationship can be manually re-started from web console.
