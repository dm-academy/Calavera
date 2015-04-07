#! /bin/bash

#install Vagrant
#install chefdk
#install virtualbox plugin
#install berkshelf plugin
# fix that pesky berkshelf issue with **/.git


vagrant destroy base -f  # insert guard
rm -f package.box
rm -f ./shared/keys/*   # re-set public/private keys
vagrant box add http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box --name opscode/temp --force
vagrant up base
vagrant package base
vagrant box add opscode-ubuntu-14.04a package.box -f
rm -f package.box
vagrant destroy base -f
