#
# Cookbook Name:: shared
# Recipe:: default - run on every node
#
# Copyright (c) 2015 Charles T Betz, All Rights Reserved.
# Recipe for all nodes within Calavera

# from files directory

#ssh and network setup

# from files directory

file_map = {
 "calaverahosts" => "/home/vagrant/calaverahosts",  # there is now a recipe for managing hosts
 "ssh.sh" => "/home/vagrant/ssh.sh"      # copy script down. yes, would be good to rewrite it entirely in Chef/Ruby
}

# download each file and place it in right directory
file_map.each do | fileName, pathName |
  cookbook_file fileName do
    path pathName
    mode 0755
    #user "xx"
    #group "xx"
    action :create
  end
end

# convert next 2 commands to the hostsfile cookbook?

execute 'configure host file' do
  command 'cat /home/vagrant/calaverahosts >> /etc/hosts'   # REALLY not idempotent. just put a touch x guard
end

execute 'remove host file' do
  command 'rm /home/vagrant/calaverahosts'
end

# convert next command to appropriate cookbook.

execute 'configure ssh' do
  cwd "/home/vagrant"
  user "vagrant"
  group "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command "/home/vagrant/ssh.sh" # configure SSH - also not idempotent
end
