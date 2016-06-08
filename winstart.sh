#! /bin/bash

# This is to initialize Vagrant on Windows
# ONLY works with the Git for Windows Bash shell!! https://git-scm.com/download/win

# Be sure that  you have write access to C:Public

#install Vagrant
#install chefdk
#install virtualbox plugin
#install berkshelf plugin

vagrant destroy base -f  # insert guard
rm -f package.box
rm -f ./shared/keys/*   # re-set public/private keys
vagrant box add http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box --name opscode/temp --force

vagrant up base
vagrant package base
mkdir -p C:/Users/public/vagrant/boxes/   # shared public location - better enables creating mutiple pipelines

cp package.box C:/Users/public/vagrant/boxes/opscode-ubuntu-14.04a.box

vagrant box add opscode-ubuntu-14.04a C:/Users/public/vagrant/boxes/opscode-ubuntu-14.04a.box -f
rm -f package.box
vagrant destroy base -f
