# local Jenkins recipe with overrides to force earlier version
# See https://github.com/chef-cookbooks/jenkins/pull/471

#node.set[:jenkins][:master][:repository] = 'http://pkg.jenkins-ci.org/debian-stable'
#node.set[:jenkins][:master][:repository_key] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
#node.override[:jenkins][:master][:version] = '1.651.3'


include_recipe "jenkins::master"



# remote_file "/tmp/jenkins_1.653_all.deb" do
#     source 'http://pkg.jenkins-ci.org/debian/binary/jenkins_1.653_all.deb'
# end
#
#
# execute 'install Jenkins prereqs' do
#   #cwd '/home/vagrant/.ssh'    #somehow this is out of synch with /mnt/shared/keys on templated Vagrant.
#
#   #command 'cp * /var/lib/jenkins/.ssh'   # this includes authorized_keys, don't think it does any good there
#   command 'apt-get install daemon -y'  # this should be the source
# end
#
# execute 'install Jenkins ' do
#   #cwd '/home/vagrant/.ssh'    #somehow this is out of synch with /mnt/shared/keys on templated Vagrant.
#
#   #command 'cp * /var/lib/jenkins/.ssh'   # this includes authorized_keys, don't think it does any good there
#   command 'dpkg -i /tmp/jenkins_1.653_all.deb -y'  # this should be the source
# end
