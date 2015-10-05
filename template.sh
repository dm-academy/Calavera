#! /bin/bash
# this script sets up a new pipeline from the template, with environment naming as set on command line
# don't like how it edits the resources directly, would be better handled as a parameter across all the
# Chef recipes
# !!needs to be run from Calavera dir as uses relative paths, yuck

# don't forget vagrant plugin install vagrant-berkshelf

# vagrant plugin install vagrant-berkshelf
mv Vagrantfile oldVagrantfile
cp VagrantfileTemplate Vagrantfile
sed -i -- "s/xx/$1/g" Vagrantfile

# fix various resources in Chef
## cerebro
sed -i -- "s/hombros/hombros$1/g" cookbooks/cerebro/files/post-receive
sed -i -- "s/cerebro/cerebro$1/g" cookbooks/cerebro/files/post-receive

## brazos - no corrections needed

## espina - no corrections needed

## hombros
sed -i -- "s/espina/espina$1/g" cookbooks/hombros/files/*.xml
sed -i -- "s/brazos/brazos$1/g" cookbooks/hombros/recipes/default.rb
sed -i -- "s/cerebro/cerebro$1/g" cookbooks/hombros/recipes/default.rb

## manos
sed -i -- "s/cerebro/cerebro$1/g" cookbooks/manos/recipes/default.rb

## cara
sed -i -- "s/espina/espina$1/g" cookbooks/cara/recipes/default.rb
