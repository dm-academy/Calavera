# local Jenkins recipe with overrides to force earlier version
# See https://github.com/chef-cookbooks/jenkins/pull/471

node.set[:jenkins][:master][:repository] = 'http://pkg.jenkins-ci.org/debian-stable'
node.set[:jenkins][:master][:repository_key] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
node.override[:jenkins][:master][:version] = '1.651.3'
include_recipe "jenkins::master"
