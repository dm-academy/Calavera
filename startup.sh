#! /bin/bash
# RUN AS SUDO
#install Vagrant
#install chefdk
#install virtualbox plugin
#install berkshelf plugin
# fix that pesky berkshelf issue with **/.git


vagrant plugin install vagrant-berkshelf
vagrant destroy base -f  # insert guard
rm -f package.box
rm -f ./shared/keys/*   # re-set public/private keys
vagrant box add http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box --name opscode/temp --force

vagrant up base
vagrant package base
mkdir -p /var/vagrant/boxes/   # shared public location
cp package.box /var/vagrant/boxes/opscode-ubuntu-14.04a.box
vagrant box add opscode-ubuntu-14.04a /var/vagrant/boxes/opscode-ubuntu-14.04a.box -f
chown $USER -R ~/.vagrant.d/boxes/opscode-ubuntu-14.04a
chown $USER -R shared/keys    #you shouldn't be running this script anywhere else
rm -f package.box
vagrant destroy base -f
