# set up developer workstation

# assuming Chef has set up Java, Tomcat, ant and junit
# need to establish directory structure
# move source code over
# run Ant # OR... have Jenkins do? Or do manually? 
# remote push Git?

group 'git'

group 'jenkins'

user 'git' do
  group 'git'
end

user 'vagrant' do
  group 'git'
end

user 'jenkins' do
  group 'jenkins'
  group 'git'
end

directory "/home/hijo.git/"  do
    mode 00775
    owner "git"
    group "git"
    action :create
    recursive true
end

directory "/home/jenkins/.ssh"  do
    mode 00775
    owner "jenkins"
    group "git"
    action :create
    recursive true
end

execute 'Jenkins keys' do
  cwd '/home/vagrant/.ssh'
  command 'cp id_rsa* /home/jenkins/.ssh'
end

execute 'correct Jenkins ssh keys ownership' do
  command 'chown -R jenkins /home/jenkins &&  \
          chgrp -R jenkins /home/jenkins'  
end

execute 'init git' do
  user "git"
  group "git"
  command 'git init --bare --shared=group /home/hijo.git'
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
