calavera
========

This is a project to create a simplified, reproduceable DevOps pipeline for educational purposes, using git, Vagrant, Java, JUnit, Ant, Jenkins, Chef, and a package repository still to be selected.  

See https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Home and other wiki pages for full, evolving description. See http://www.lean4it.com/2014/10/devops-simulation-for-education.html for initial motivation. 

2015-02-09 update:
=======

I have been heads down in R&D and admittedly lax in checking things in. Since I last updated I moved things over to Chef Kitchen, and the use of Chef gave me powerful abilities to automate Jenkins, so I am glad I did so. 

BUT... I do not want to tightly couple Calavera to Chef. So, I do not want a .kitchen.yml file driving everything. I therefore am going to (as "third time's the charm") go back to a Vagrantfile as the prime mover, using Chef Solo as appropriate for expedited, dependency-aware configuration and automation. 

2015-01-18 directional update:
========
To this point, all of the infrastructure was running well on default-sized Vagrant VMs (512m) and I could have it all on my Mac Air. This was making it possible to consider that any student with a 2-4gb laptop would be able to run the whole thing, especially if I tuned some of the machines down even further. (This is different from what the architecture diagram suggests, which is that the student is only running the Manos workstation locally.)

Enter Chef Server. Attempting to install it on anything less than a VM with its own 4gb of RAM gives unpredictable results (that weren't obviously capacity-related, so I spent some cycles trying to run them down). So, it will not be possible for students to run Chef Server on their own laptops. 

I am therefore going down the road of Chef Zero (formerly Solo), but will still run Chef Server in the lab. I have not yet sorted out pedgogically the relationship between the larger, presumably more stable lab instance of the pipeline versus a more disposable laptop instance of the entire thing. It would be nice if the students did not have to ssh into school, which imposes certain overheads I'd like to avoid. In either case the pipeline needs to be something that can be bootstrapped using Infrastructure as Code from a source repository. 

2015-01-17 directional update:
========
On to Chef! I have to recast all the provisioning shell scripts into Chef recipes. Why didn't I start with this? It would have been better in hindsight. But I have refreshed my shell scripting abilities which is good. Basically, I had two choices: build the project from an application-centric view, tracking the pipeline, vs. building it up from infrastructure. I chose the former, and am now paying the price. Digging into the very steep Chef learning curve... 
Some may ask "why not puppet" and I have two responses, one strategic, the other tactical. 

Strategically, it seems to me that Chef is a bit "closer to the metal" and less "magic" than Puppet, which is how I want my students to learn. 

Tactically, I see a Chef recipe that is capable of auto-provisioning Jenkins nodes. I spent a very frustrating day yesterday trying to get the Jenkins CLI to auto-provision and credential new slave nodes (it was the credentialing where things fell apart.) Doesn't seem to be possible without getting much further into the Jenkins class model than I wanted to deal with. The only people that seem to have done it are Chef and a Python plugin. 

Looking for guidance, if anyone can point to something I have missed. 

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
