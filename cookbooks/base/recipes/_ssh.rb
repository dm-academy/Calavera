# Cookbook Name:: shared
# Recipe:: _ssh - run on base node
#
# Copyright (c) 2015 Charles T Betz, All Rights Reserved.
# Recipe for all nodes within Calavera


file_map = {
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


execute 'configure ssh' do
  cwd "/home/vagrant"
  user "vagrant"
  group "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command "/home/vagrant/ssh.sh" # configure SSH - also not idempotent
end
