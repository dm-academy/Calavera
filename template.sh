#! /bin/bash
# this script sets up a new pipeline from the template, with environment naming as set on command line
# don't like how it edits the resources directly, would be better handled as a parameter across all the
# Chef recipes
# !!needs to be run from Calavera dir as uses relative paths, yuck

# don't forget vagrant plugin install vagrant-berkshelf

# vagrant plugin install vagrant-berkshelf
cp Vagrantfile oldVagrantfile
cp VagrantfileTemplate Vagrantfile

sed -i -- "s/xx/$1/g" Vagrantfile

# sed -i -- "s/\(cerebro\|brazos\|espina\|hombros\|manos\|cara\|nervios\|pies\|test\)[0-9]*/\1$1/g" Vagrantfile  #no, breaks cookbook names

# fix various resources in Chef
## cerebro
sed -i -- "s/hombros[0-9]*/hombros$1/g" cookbooks/cerebro/files/post-receive
sed -i -- "s/cerebro[0-9]*/cerebro$1/g" cookbooks/cerebro/files/post-receive

## brazos - no corrections needed

## espina - no corrections needed

## hombros
sed -i -- "s/espina[0-9]*/espina$1/g" cookbooks/hombros/files/*.xml
sed -i -- "s/cerebro[0-9]*/cerebro$1/g" cookbooks/hombros/files/*.xml
sed -i -- "s/brazos[0-9]*/brazos$1/g" cookbooks/hombros/files/*.xml
sed -i -- "s/brazos[0-9]*/brazos$1/g" cookbooks/hombros/recipes/default.rb

## manos
sed -i -- "s/cerebro[0-9]*/cerebro$1/g" cookbooks/manos/recipes/default.rb

## cara
sed -i -- "s/espina[0-9]*/espina$1/g" cookbooks/cara/recipes/default.rb
