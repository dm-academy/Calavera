# base configuration.
# this needs to be then re-packaged to minimize virtual machine loading time while constructing the various nodes

include_recipe "apt::default"
include_recipe "java7::default"
include_recipe "curl::default"

apt_package 'tree' do
  action :install
end