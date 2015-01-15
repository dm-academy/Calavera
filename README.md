calavera
========

This is a project to create a simplified, reproduceable DevOps pipeline for educational purposes, using git, Vagrant, Java, JUnit, Ant, Jenkins, Chef, and a package repository still to be selected.  

See https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Home and other wiki pages for full, evolving description. 

2015-01-15 release update:
========
Created a new include ssh.sh which creates public/private key pair (just one for cluster) and imports it throughout, as well as adding local host names for the 5 hosts. Now, within the cluster, one can simply "ssh <hostname> from any to any and get access with no password. (First time, one has to concur w/ the fingerprint; this can be automated away if need be.)

2015-01-13 release update:
========

Installing Java on every new vagrant VM was taking way too long, so I developed a script that would bake it in (along with doing a complete software update and installing Tomcat). Everything is now dependent on a VM that has Java and Tomcat on it. 

So in order to build the project as it stands:

- Install Virtualbox
- Install Vagrant
- Recommended: install Vagrant vb-guest (https://github.com/dotless-de/vagrant-vbguest)
- cd to the Calavera/calavera-shared directory
- run BakeCalavera.sh (sorry, only supporting MacOS at this time)
- cd .. (back to the Calavera directory)
- vagrant up (the 5 vms should then be created)

Currently, the 5 vms build, but Jenkins requires manual configuration via its web portal to build the hijo project on brazos. Chef is not working yet and I have not selected a package manager.

See also https://github.com/CharlesTBetz/Calavera/wiki/Manos-release-notes on the previous release.

This all remains what I consider pre-alpha, but there may be some useful stuff here for interested parties, and it is almost suitable for instructional purposes in a high support classroom environment (class starts in 3 weeks!). 
