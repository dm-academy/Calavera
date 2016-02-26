# base configuration.
# this needs to be then re-packaged to minimize virtual machine loading time while constructing the various nodes


execute 'apt update' do
  command 'echo "apt updated"'
end

include_recipe "java7::default"
#include_recipe "java8::default"
include_recipe "curl::default"

execute 'install tree' do
  command 'apt-get -q install tree'
end
