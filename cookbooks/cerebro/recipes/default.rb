# set up central git repository server

group 'git'

group 'jenkins'

user 'git' do
  group 'git'
end

user 'vagrant' do
  group 'git'
end

user 'jenkins' do   # jenkins will need to ssh in to retrieve files to build
  group 'jenkins'
  group 'git'
end

directory "/home/jenkins/.ssh"  do
    mode 00700      # this will fail with other permissions
    owner "jenkins"
    group "git"
    action :create
    recursive true
end

execute 'Jenkins keys' do
  #cwd 'home/vagrant/.ssh' # somehow out of synch in templated version, suspect startup.sh issue
  #command 'cp * /home/jenkins/.ssh'  # this should include authorized keys.
  command 'cp /mnt/shared/keys/* /home/jenkins/.ssh'  # this should be the source - fixes part of problem
  command 'cat /home/jenkins/.ssh/id_rsa.pub > /home/jenkins/.ssh/authorized_keys'
end

execute 'correct Jenkins ssh files ownership' do
  command 'chown -R jenkins /home/jenkins &&  \
          chgrp -R jenkins /home/jenkins'
end

### hijo config

directory "/home/hijo.git/"  do
    mode 00775
    owner "git"
    group "git"
    action :create
    recursive true
end

execute 'init git' do
  user "git"
  group "git"
  command 'git init --bare --shared=group /home/hijo.git'
end

execute 'init git' do
  user "git"
  group "git"
  cwd '/home/hijo.git'
  command "git config receive.denynonfastforwards false"    # this way we can force wipe from manos if manos is rebuilt after cerebro
end
#configure post receive hook
# that means manos is dependent on havng cerebro done in terms of ordering

cookbook_file "post-receive" do
    path "/home/hijo.git/hooks/post-receive"
    user "jenkins"
    group "jenkins"
    mode 00755    # must be executable
    action :create
end
