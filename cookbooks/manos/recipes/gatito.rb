
# manos-default

# set up developer workstation

# assuming Chef has set up Java, Tomcat, ant and junit
# need to establish directory structure
# move source code over
# run Ant # OR... have Jenkins do? Or do manually?
# remote push Git?

package "tree"

group 'git'

user 'vagrant' do
  group 'git'
end

["/home/gatito/src/main/config",
 "/home/gatito/src/main/java/biz/calavera",
 "/home/gatito/src/test/java/biz/calavera",
 "/home/gatito/target/biz/calavera"].each do | name |

  directory name  do
    mode 00775
    action :create
    user "vagrant"
    group "git"
    recursive true
  end
end

file_map = {
  "INTERNAL_gitignore" => "/home/gatito/.gitignore",
 "build.xml" => "/home/gatito/build.xml",
 "web-gatito.xml" => "/home/gatito/src/main/config/web.xml",
 "Class1.java" => "/home/gatito/src/main/java/biz/calavera/Class1.java",
 "MainServlet.java" =>  "/home/gatito/src/main/java/biz/calavera/gatito.java",
 "TestClass1.java" => "/home/gatito/src/test/java/biz/calavera/TestClass1.java"
}

# download each file and place it in right directory
file_map.each do | fileName, pathName |
  cookbook_file fileName do
    path pathName
    user "vagrant"
    group "git"
    action :create
  end
end

execute 'correct dev directory permissions' do
  command 'chown -R vagrant /home/gatito/ && chgrp -R git /home/gatito/'          # Chef does not have an easy way to do this.
end

execute 'correct tomcat webapps permissions' do
  command   'chown -R vagrant /var/lib/tomcat6/webapps/ && chgrp -R vagrant /var/lib/tomcat6/webapps/'    #
end

execute 'initial build & dev deploy' do
  user "vagrant"
  group "git"
  cwd '/home/gatito'
  command 'ant'
end

execute 'initialize git 1' do
  user "vagrant"
  group "git"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git config --global user.email "char@calavera.biz"'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 2' do
  user "vagrant"
  group "git"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git config --global user.name "Charles Betz"'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 3' do
  user "vagrant"
  group "git"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git init /home/gatito'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 4' do
  user "vagrant"
  group "git"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git add .'   # needs to be idempotent
end

execute 'initialize git 5' do
  user "vagrant"
  group "git"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git commit -m "initial commit"'   # needs to be idempotent
end

execute 'register server' do
  user "vagrant"
  group "git"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'ssh-keyscan cerebro >> ~/.ssh/known_hosts'   # prevents interactive dialog
end

execute 'define remote' do
  user "vagrant"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git remote add origin ssh://cerebro/home/gatito.git'   # define master git server. high priority to make idempotent.
end


execute 'push to remote' do
  user "vagrant"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git push origin --mirror'   # erase master - if rebuilding manos, assume this is desired. may want to reconsider.
end

execute 'push to remote' do
  user "vagrant"
  cwd '/home/gatito'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git push origin master'   # push to master git server
end
