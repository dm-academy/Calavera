# Installing Calavera



## Prerequisites

As github projects go, this one is intended to be accessible to the person of "general computing literacy." If you are interested in getting started with establishing a Github track record, this might be a good project to start with. There is a diversity of technology here, and some nontrivial tools, but the concepts are all relatively simple. This really is more about systems administration than true software development.  

In terms of skills, you need to be able to install software on your computer, edit text files (NOT using Microsoft Word), and be comfortable with a command prompt. You need some understanding of basic computing, virtualization, networking, and the like. You should have at least a little programming or scripting ability.

You also need at least a little Vagrant. It is probably the easiest tool in the box here to familiarize yourself with, and there is good material on the web just a Google search away. Spend an hour with the Vagrant tutorial and vagrant up a simple VM or two and you'll be more or less ready for this.

You'll find yourself learning Chef, but since you are starting with a simple, functioning set of interrelated recipes it's not a bad way to start. This project might make a good adjunct if you're running a Chef tutorial. If you want to modify or extend the system, you'll have to pick up some Ruby. There's also a few \*.bash scripts.

You need enough git to clone this repository to your machine. That's just one command, shown below. But it would be nice if you could help improve the project by forking your own repo, making enhancements, and sending up pull requests. They will be reviewed and acted upon.

You need:

* Internet connectivity for all the install steps (the cluster will run without Internet once it is up)

* Recent (< 3 yrs old) Pentium or Xeon or similar class AMD chip, multi-core preferable.

* Windows 7+, Mac OS X Mavericks or later, or Ubuntu 14 (note: I have not done extensive version testing; if you have a platform that runs the prequisites listed below it probably will work)

* At least 8 GB of RAM (16 or more recommended; if you have 4 you can try --  shut everything else off) and a computer capable of running 64-bit VMs

* AT LEAST 20 gb of free hard drive space
* Strongly recommend a visualizer so you can monitor VM consumption of disk:
  * [WinDirStat](https://windirstat.info/) for Windows
  * [KDirStat](http://kdirstat.sourceforge.net/) for Unix & Linux
  * [DiskInventoryX](http://www.derlien.com/) for Mac

* You may need to enable [hardware acceleration](http://www.sysprobs.com/disable-enable-virtualization-technology-bios)

The virtual machines use a range of local IP addresses from 192.168.33.29 through 192.168.33.36. Make sure you are not using those for some other project.

You also may wish to review the [Vagrantfile](https://github.com/CharlesTBetz/Calavera/blob/master/Vagrantfile) for port redirect conflicts. A consistent numeric approach has been adopted for redirecting 22, 80 and 8080. If you don't know what this is about that's fine for now.

## Installation precursors and overview

First, you need to install:

* [VirtualBox](https://www.virtualbox.org/)
* [Chef Development Kit](https://downloads.chef.io/chef-dk/) latest version
* [Vagrant](http://www.vagrantup.com/downloads.html)
  * [Vagrant Berkshelf plugin](https://github.com/berkshelf/vagrant-berkshelf)
  * [Vagrant VBoxGuest plugin](https://github.com/dotless-de/vagrant-vbguest)

And of course you will need [git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), to download from Github.

On Windows: install [Git for Windows](https://git-scm.com/download/win), accepting defaults. Github for Windows is not recommended.

Calavera starts with a script, "startup.sh" or "startup.bat", which takes a standard Opscode image and adds:

* Chef
* Java
* Virtualbox addins
* curl & tree

It then repackages it and destroys the Vagrant machine. The remaining 6 VMs all then use this repackaged base image.

The VMs need to be instantiated in a particular order:

1. cerebro1 (Remote git repo)
1. brazos1 (Slave build environment)
1. espina1 (Artifactory)
1. hombros1 (Jenkins)
1. manos1 (Development environment)
1. cara1 (Production environment)

Any other order will likely result in errors and a "cluster" in another sense of that word.

## Issues

I  am actively monitoring [Github Issues for this project](https://github.com/CharlesTBetz/Calavera/issues). If you run into something, please post there.

## Installation step by step

Disclaimner: this is still very early stage work. Many failure modes.

Detailed installations for all precursors are available through their associated sites. Default installations should all work (let me know if this is not the case.)


Open a command prompt.

Figure out a suitable location (e.g. in your home directory) to download the repository from Github.

Open a command window in your chosen location. (On Windows, open Windows Explorer, navigate to the directory you want, right click, and choose "Git Bash Here.")

Type:

    git clone https://github.com/CharlesTBetz/Calavera.git
    cd Calavera

Continue below with your appropriate platform.

### Linux and Mac OS (see below for Windows)
Type:

````
./startup.sh
````
### Windows

Type:
````
./winstart.sh  (or startup.bat on windows)
````
NOTE: On Windows, you will receive multiple User Account Control notifications as Vagrant brings up Virtualbox VMs.

You also will receive a network security alert.

Authorize all with defaults.

### Common steps across all platforms

CD to the new Calavera directory, and run the following, one at a time. They will generate LOTS of console output, but hopefully no errors. This may take you around 20 minutes. It will appear to hang in places (Java related stuff in particular); give it at least 15 minutes before killing anything.

At your shell:
````
vagrant up cerebro1
vagrant up brazos1
vagrant up espina1
vagrant up hombros1
````
or (if you are impatient) the following works:
````
vagrant up cerebro1 brazos1 espina1 hombros1
````

All done with those first 4? Good.

### Bringing up manos1

Now, the acid test: bringing up manos1. The user guide (to be written) will go into details on this, but let's just say there are a lot of ways Manos can fail. The precursor machines must have all come up without error.

    vagrant up manos1

If the console output seems to have gone without a hitch, go first to Jenkins. As part of its provisioning, manos does an initial ant build & test, local Tomcat deployment, and git commit and remote push which should result in a Jenkins build and an Artifactory check in.

To check all this out, first go to:

http://192.168.33.34:8080/MainServlet

This is the developer instance of Tomcat. You should see the Calavera message there.

![](img/ManosServletView.png)

Then, go to Jenkins.

http://192.168.33.33:8080

You should see a first successful build:
![](img/JenkinsSuccess.png)

(Feel free to click on the "#1" and poke around.)

Finally, if you go to:

http://192.168.33.32:8081/artifactory/webapp/home.html

you will see that Artifactory is now "happily serving 2 artifacts." Hooray! Click on the "Artifacts" tab:

![](img/ArtifactorySuccess2.png)

and if you expand the tree node that says "ext-release-local" (remember configuring that above?) you will see that the Calavera release artifacts are deployed and ready for production!

![](img/ArtifactorySuccess3.png)

[author's note: take a pre-manos shot of hombros espina for contrast next time it is built]

### Deploying to cara1

Bringing up cara1 is a little anticlimactic.

    vagrant up cara1

Assuming everything previously went well, chef will pull the .jar and .xml file from Artifactory on espina and deploy and restart Tomcat. You can go to:

http://192.168.33.35:8080/MainServlet

and should see:

![](img/CaraSuccess.png)

Hooray! What next?

A user guide is in process to describe the various aspects of Calavera and how to actually use and extend the pipeline. Stay tuned. Or better yet, help!
