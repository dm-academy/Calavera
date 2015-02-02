# set up developer workstation

# assuming Chef has set up Java, Tomcat, ant and junit
# need to establish directory structure
# move source code over
# run Ant # OR... have Jenkins do? Or do manually? 
# remote push Git?

group 'git'

user 'vagrant' do
  group 'git'
end

["/home/hijo/src/main/config",
 "/home/hijo/src/main/java/biz/calavera", 
 "/home/hijo/src/test/java/biz/calavera",
 "/home/hijo/target/biz/calavera"].each do | name |

  directory name  do
    mode 00775
    action :create
    recursive true
  end
end


file_map = {
  "INTERNAL_gitignore" => "/home/hijo/.gitignore",
 "build.xml" => "/home/hijo/build.xml",
 "web.xml" => "/home/hijo/src/main/config/web.xml", 
 "Class1.java" => "/home/hijo/src/main/java/biz/calavera/Class1.java",
 "MainServlet.java" =>  "/home/hijo/src/main/java/biz/calavera/MainServlet.java",
 "TestClass1.java" => "/home/hijo/src/test/java/biz/calavera/TestClass1.java"
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
  command 'chown -R vagrant /home/hijo/* &&  \
           chgrp -R git /home/hijo/*'          # Chef does not have an easy way to do this. 
end

execute 'correct tomcat webapps permissions' do
  command   'chown -R vagrant /var/lib/tomcat6/webapps/* &&     \
             chgrp -R vagrant /var/lib/tomcat6/webapps/*'    #
end

execute 'initial build & dev deploy' do
  user "vagrant"
  group "git"
  cwd '/home/hijo'
  command 'ant'
end

execute 'initialize git' do
  user "vagrant"
  group "git"
  command 'git init /home/hijo'   # needs to be idempotent. can we do this through git cookbook?
end

execute 'initialize git 2' do
  user "vagrant"
  group "git"
  cwd '/home/hijo'
  command 'git add .'   # needs to be idempotent
end

execute 'initialize git 3' do
  user "vagrant"
  group "git"
  cwd '/home/hijo'
  command 'git commit -m "initial commit"'   # needs to be idempotent
end

execute 'register server' do
  user "vagrant"
  command 'ssh-keyscan cerebro >> ~/.ssh/known_hosts'   # prevents interactive dialog
end

execute 'define remote' do
  user "vagrant"
  cwd '/home/hijo'
  command 'git remote add origin ssh://cerebro/home/hijo.git'   # define master git server
end

execute 'push to remote' do
  user "vagrant"
  cwd '/home/hijo'
  command 'git push origin master'   # push to master git server
end



