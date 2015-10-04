#! /bin/bash
# this script sets up a new pipeline from the template, with environment naming as set on command line
# don't like how it edits the resources directly, would be better handled as a parameter across all the
# Chef recipes
# needs to be run from Calavera dir as uses relative paths, yuck

# don't forget vagrant plugin install vagrant-berkshelf

vagrant plugin install vagrant-berkshelf
mv Vagrantfile oldVagrantfile
cp VagrantfileTemplate Vagrantfile
sed -i -- "s/xx/$1/g" Vagrantfile

# fix various resources in Chef
