Installing Calavera
==
2015-03-01  version 0.1 alpha

Prerequisites
--

You need:

* Recent (< 3 yrs old) Pentium or Xeon or similar class AMD chip, multi-core preferable.

* Windows 7+, Mac OS X Mavericks or later, or Ubuntu 14 (note: I have not done extensive version testing; if you have a platform that runs the prequisites listed below it probably will work)

* At least 4 GB of RAM and a computer capable of running 64-bit VMs

* AT LEAST 20 gb of free hard drive space
* Strongly recommend a visualizer so you can monitor VM consumption of disk:
  * [WinDirStat](https://windirstat.info/) for Windows
  * [KDirStat](http://kdirstat.sourceforge.net/) for Unix & Linux
  * [DiskInventoryX](http://www.derlien.com/) for Mac

* You may need to enable [hardware acceleration](http://www.sysprobs.com/disable-enable-virtualization-technology-bios)

Installation overview
--

First, you need to install:

* [VirtualBox](https://www.virtualbox.org/)

* [Vagrant](http://www.vagrantup.com/downloads.html)
  * [Vagrant Berkshelf plugin](https://github.com/berkshelf/vagrant-berkshelf)
  * [Vagrant VBoxGuest plugin](https://github.com/dotless-de/vagrant-vbguest)
* [Chef Development Kit](https://downloads.chef.io/chef-dk/)

And of course you will need git, to download from Github, thus:

    git clone https://github.com/CharlesTBetz/Calavera.git

Calavera starts with a script, "startup.sh" or "startup.bat", which takes a standard Opscode image and adds:

* Chef
* Java
* Virtualbox addins
* curl & tree

It then repackages it and destroys the Vagrant machine. The remaining 6 VMs all then use this repackaged base image.

The VMs need to be instantiated in a particular order, with one manual intervention:

1. cerebro (Remote git repo)
1. brazos (Slave build environment)
1. espina (Artifactory)
1. hombros (Jenkins)
1. **manually setup jenkins to use artifactory**
1. manos (Development environment)
1. cara (Production environment)

Any other order will likely result in errors and an unusable cluster. So:

````
vagrant up cerebro
vagrant up brazos
vagrant up espina
vagrant up hombros
````

We have to set up Artifactory in Jenkins because the Jenkins API does not support configuring Artifactory in an automated way, as far as I can see.
