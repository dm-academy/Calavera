Calavera
========

This is a project to create a simplified, reproduceable DevOps pipeline for educational purposes. It uses  "infrastructure as code" principles to configure git, Vagrant, Java, JUnit, Ant, Jenkins, Chef Zero, and Artifactory into an integrated, end to end system.

There are a number of benefits you might find in this project. While the basic DevOps principles it illustrates are simple and widely understood, it can nevertheless be frustrating to properly configure all the interactions in an end to end DevOps pipeline. There are any number of issues lurking in integrating the pipeline: .ssh setup, permissions, build choreography interactions (e.g. git/Jenkins/Artifactory), software versions, and the like.

This gives you a functioning starting point, a "known good" baseline running as a cluster of 6 Ubuntu VMs under Vagrant and Chef, that does the following:

* Gives you a basic test-driven "Hello World" Java example with JUnit, Ant, Tomcat, and git.
* When you execute a build on that environment, if successful it pushes to a remote master git repository.
* That commit then triggers Jenkins to execute a build on a "slave" node.
* If that build succeeds, the result is archived to Artifactory.
* You then can (with Chef) deploy the result to a simulated "production" node.

All the configurations are expressed in the Vagrantfile and the Chef cookbooks, so you can inspect and adapt them. No magic here. See [the instructions](https://github.com/CharlesTBetz/Calavera/blob/master/docs/Installation.md). 

Some may be particularly interested in the Calavera example of how Chef can provision Jenkins through the Jenkins api. This includes provisioning and controlling a slave, integrating with git through a githook, and integrating with Artifactory. It's all there; have a go with it. The Vagrant machine that runs Jenkins is called "hombros." See [the hombros cookbook](https://github.com/CharlesTBetz/Calavera/blob/master/cookbooks/hombros) and [the brazos cookbook](https://github.com/CharlesTBetz/Calavera/blob/master/cookbooks/brazos).

![](docs/img/CalaveraArchitecture.jpg)

See https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Home and other wiki pages for full, evolving description.

See http://www.lean4it.com/2014/10/devops-simulation-for-education.html for initial motivation.

Installation
==

[Installation instructions](https://github.com/CharlesTBetz/Calavera/blob/master/docs/Installation.md)


2015-03-03 0.3 Alpha Released!
==
Open for business. Please let me know what you think. And please help. 


2015-03-01 update
==
*2015-03-02 note OK I changed my mind about releasing. After I finished the installation instructions yesterday and confirmed a couple succesful builds on different machines, I decided to go ahead and call 0.3 the first official alpha release.*

The last 3 weeks have marked Calavera's debut in a classroom setting. It has been a lot of work and very exciting for both me and (I think) the students. This week, they are [standing up their own instances of the Manos development environment](https://github.com/StThomas-SEIS660/Lab-04/blob/master/Lab-04-inststructions.md).

Been doing some final polishing. The public Calavera alpha release is delayed due to my educational commitments - have to prioritize creating the labs. Testing the system under fire in the classroom also seems appropriate before publishing.

But a motivated person can certainly download and stand up the virtual machines at this point. I am currently working on the [installation instructions](https://github.com/CharlesTBetz/Calavera/blob/master/docs/Installation.md).

See previous updates on the [Calavera blog](https://github.com/CharlesTBetz/Calavera/wiki/Calavera-Blog)

Future directions
==
The next major steps will be:
* Create a [MEAN-stack](http://en.wikipedia.org/wiki/MEAN) based development pipeline
* Support Docker in addition to VirtualBox (may deprecate VirtualBox, depending)
* Integrate with Cloud providers

Charles Betz personal statement
==

I'm an architect, advisor, and instructor. My career focus has been the "business of IT" including concerns such as enterprise architecture, IT service management, IT portfolio management, and IT financial management. However, I also believe that hands on engagement is essential.

I am not a professional software developer, infrastructure engineer, or systems administrator, although I know many. I have the deepest admiration for the professionals I see here on Github developing Vagrant plugins, Chef cookbooks, and the like. I know my work is not up to that standard. There are any number of aspects in these scripts that professionals might criticize. In part, this project has helped me learn the technologies at hand, so it is by definition amateurish.

However, as near as I can tell the concept is original, and I intend to build on it far beyond a DevOps pipeline. As part of the InsanIT initiative, it realizes the architecture principles I am using in my 3rd edition of *The Architecture of IT Management*. It is also a reference implementation of [IT4IT](http://opengroup.org/it4it). More to come on this.

I welcome collaborators and am ready to entertain pull requests if anyone wants to help. This work is a life priority for me.

One audience that I hope will find benefit in this is people like me - mid-career types who are watching all the buzz about DevOps in the media and looking for some accessible way to get a little deeper into it. Folks, when I started this I did not know ANY of the technologies here except a little bit of Java.

You can of course take 2 week courses in each of these technologies, but this is an alternate approach: see just enough of each in action to understand how it contributes to the overall system. It's been well worth it for me.

See [the wiki](https://github.com/CharlesTBetz/Calavera/wiki) for further information. And of course www.lean4it.com. 
