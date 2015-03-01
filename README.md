Calavera
========

This is a project to create a simplified, reproduceable DevOps pipeline for educational purposes, using git, Vagrant, Java, JUnit, Ant, Jenkins, Chef Zero, and Artifactory.

There are a number of benefits you might find in this project. While the basic DevOps principles it illustrates are simple and widely understood, it can nevertheless be frustrating to properly configure all the interactions in an end to end DevOps pipeline. There are any number of issues lurking in integrating the pipeline: .ssh setup, permissions, Jenkins and Artifactory interaction, software versions, and the like.

This gives you a functioning starting point, a "known good" baseline running as a cluster of 6 Ubuntu VMs under Vagrant and Chef, that does the following:

* Gives you a basic test-driven Java example with JUnit, Ant, Tomcat, and git.
* When you execute a build on that environment, if successful it pushes to a remote master git repository
* That commit then triggers a Jenkins build on a "slave" node
* If that build succeeds, the result is archived to Artifactory
* You then can (with Chef) deploy the result to a simulated "production" node.

![](https://github.com/CharlesTBetz/Calavera/blob/master/docs/img/CalaveraArchitecture.jpg)

See https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Home and other wiki pages for full, evolving description.

See http://www.lean4it.com/2014/10/devops-simulation-for-education.html for initial motivation.

Charles Betz personal statement
==

I'm an architect, advisor, and instructor, who believes that being grounded in hands on work is essential.

I am not a professional software developer, infrastructure engineer, or systems administrator, although I know many. I have the deepest admiration for the professionals I see here on Github developing Vagrant plugins, Chef cookbooks, and the like. I know my work is not up to that standard. There are any number of aspects in these scripts that professionals might criticize. In part, this project has helped me learn the technologies at hand, so it is by definition amateurish.

However, as near as I can tell the concept is original, and I intend to build on it far beyond a DevOps pipeline. As part of the InsanIT initiative, it is the realization of the architecture principles I am using in my 3rd edition of *The Architecture of IT Management*. More to come on this.

I welcome collaborators and am ready to entertain pull requests if anyone wants to help. This work is a life priority for me.

See [the wiki](https://github.com/CharlesTBetz/Calavera/wiki) for further inforamtion.

Installation
==

[Installation instructions](https://github.com/CharlesTBetz/Calavera/wiki/Installation-instructions)


2015-03-01 update
==
The last 3 weeks have marked Calavera's debut in a classroom setting. It has been a lot of work and very exciting for both me and (I think) the students. This week, they are [standing up their own instances of the Manos development environment](https://github.com/StThomas-SEIS660/Lab-04/blob/master/Lab-04-inststructions.md).

Been doing some final polishing. The public Calavera alpha release is delayed due to my educational commitments - have to prioritize creating the labs. Testing the system under fire in the classroom also seems appropriate before publishing.

But a motivated person can certainly download and stand up the virtual machines at this point. I have started a dedicated [installation instructions wiki](https://github.com/CharlesTBetz/Calavera/wiki/Installation-instructions).

See previous updates on the [Calavera blog](https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Blog)

Future directions
==
The next major steps will be:
* Create a [MEAN-stack](http://en.wikipedia.org/wiki/MEAN) based development pipeline
* Support Docker in addition to VirtualBox (may deprecate VirtualBox, depending)
