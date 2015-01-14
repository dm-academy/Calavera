#! /usr/bin/env bash
# Manos instance
# this script is for provisioning a new Vagrant CentOS 6.5 instance for the calavera project.
# this instance for the manos project represents an end developer instance, with:
#   Java
#   ant
#   junit
#   git
#   tomcat

#   Todo: it should download the skeleton Java/Tomcat project, and do an initial build.

source /mnt/public/ssh.sh


# Ant install
source /mnt/public/ant.sh

# JUnit install
source /mnt/public/junit.sh

# Git install
source /mnt/public/git.sh

###############################################################################
###########################    BUILD APP     ##################################
###############################################################################

echo "initial build &, deploy, restart Tomcat..."
rm -rf /home/hijo
cp -rf /home/calavera/hijo /home # by doing this then it's no longer in the shared directory, preventing github backup
                                # Notice this did NOT copy .vagrant because it's hidden. Good thing.

cd /home/hijo
/usr/share/apache-ant-1.9.4/bin/ant   #
                                        # ./bin/ant not in path yet, I suppose I could fix this above
                                        # note that build is running as root
                                        
# need to update permissions once more after build
# otherwise non root will not be able to run build
chmod -R 777 /usr/share/apache-tomcat-8.0.15/ 
echo "point your browser at "
echo "http://localhost:8184/MainServlet"

# now to initialize git locally and remotely
# this means that manos script will be dependent on espina, but I guess that is fine
# after all this is supposed to be a complete system

###############################################################################
#######################   INITIALIZE GIT  #####################################
###############################################################################

# we'll see when we need these
# introduces the issue of security & identity within the sandbox
# git config --global user.name
# git config --global user.email

# generate key and get it over to espina. chicken and egg problem.
# perhaps should be generated outside of simulation
# at least, should ideally be generated on piernas
# ssh-keygen -t rsa -N "" -f ~/.ssh/id-rsa  # this generates a public key. but we pre-generated.

cd /home/hijo           # just to be safe
mv /home/hijo/INTERNAL_gitignore /home/hijo/.gitignore #tricky. we cannot have this named .gitignore when
                                                        # it is under Github source control!
git init
git add .
git commit -m "initial commit"

####remote commit - assumes espina is configured. 

#note that espina/hijo.git is ignored in GitHub .gitignore file
#cp /mnt/public/id-rsa  ~/.ssh/
#ssh-keyscan -H 192.168.33.13 >> ~/.ssh/known_hosts
#git remote add /home/hijo/espina.hijo ssh://root@192.168.33.13/home/calavera/hijo.git 
#git push espina.hijo master

# git push espina.hijo master  #and... of course this won't work non-interactively.
# time to figure out keys. 

#...considered whether it would be more "idiomatic" to pull & build, but the problem is that I have to
# push from somewhere to the bare repo. so it really does start on manos. so manos has to be built last.





