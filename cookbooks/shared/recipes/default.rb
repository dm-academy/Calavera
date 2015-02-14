#
# Cookbook Name:: shared
# Recipe:: default - run on every node
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
# Recipe for all nodes within Calavera

# from files directory

# standard config, factor out

#include_recipe "apt::default"
#include_recipe "curl::default"
#include_recipe "java7::default"

#execute 'apt update' do
#  command 'apt-get -q update'   
#end

#execute 'install tree' do
#  command 'apt-get -q install tree'   
#end

#ssh and network setup

# from files directory

file_map = {
 "calaverahosts" => "/home/vagrant/calaverahosts",
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
  user "vagrant"
  group "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'}) 
  command "/home/vagrant/ssh.sh" # configure SSH - also not idempotent
end





