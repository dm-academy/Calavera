# Vagrantfile template
# you need to replace all 0 with digit 1-9
# hostnames are hard coded in following locations:
# cerebro|files|post-receive
# manos::default
#
# do NOT just "vagrant up" this whole cluster. not recommended.
# currently, need to do startup.sh and then vagrant up the machines one by on in this order
#  cerebro, brazos, espina, hombros, manos, cara

#Berksfile tweak needed per https://github.com/berkshelf/vagrant-berkshelf/issues/237  **/.git

# dependencies:
  # manos => cerebro
  # manos => hombros
  # hombros => brazos
  # hombros => espina
  # hombros => cerebro
  # cara => espina

Vagrant.configure(2) do |config|
  if ARGV[1]=='base'
    config.vm.box = "opscode/temp"
  else
    config.vm.box_url = "/var/vagrant/boxes/opscode-ubuntu-14.04a.box" # if this errors, you need startup.sh run
    config.vm.box = "opscode-ubuntu-14.04a"  # this box will not be on your machine to start
  end
  config.berkshelf.enabled = true

  # how to boost capacity
      #config.vm.provider :virtualbox do |virtualbox|
      #virtualbox.customize ["modifyvm", :id, "--memory", "1024"]   # e.g. for Chef Server
      #virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    #end

###############################################################################
###################################    base   #################################
###############################################################################

# Called by startup.sh. You should NOT "vagrant up base" directly, as it also needs
# to be repackaged
#
# purpose of doing this is to save time
# eliminates repeated chef, virtualbox utils & java downloads, also apt-get updates & installs tree & curl
# also configures ssh & hosts

  config.vm.define "base" do | base |
    base.vm.host_name              ="base.calavera.biz"
    base.vm.network                 "private_network", ip: "10.0.0.99"
    base.vm.network                 "forwarded_port", guest: 22, host: 2229, auto_correct: true
    base.vm.network                 "forwarded_port", guest: 80, host: 8029
    base.vm.network                 "forwarded_port", guest: 8080, host: 8129

    base.vm.synced_folder           ".",         "/home/base"
    base.vm.synced_folder           "./shared", "/mnt/shared"

    base.vm.provision :chef_zero do |chef|
      chef.cookbooks_path           = ["./cookbooks/"]
      chef.add_recipe               "base::default"  # java, curl and tree
      chef.add_recipe               "base::_hosts"
      chef.add_recipe               "base::_ssh"

    end
  end

###############################################################################
###################################    cerebro0   ##############################
###############################################################################

  config.vm.define "cerebro0" do | cerebro0 |
    cerebro0.vm.host_name           ="cerebro0.calavera.biz"
    cerebro0.vm.network             "private_network", ip: "10.0.0.10"
    cerebro0.vm.network            "forwarded_port", guest: 22, host: 2010, auto_correct: true
    cerebro0.vm.network            "forwarded_port", guest: 80, host: 8010, auto_correct: true
    cerebro0.vm.network             "forwarded_port", guest: 8080, host: 9010, auto_correct: true

    cerebro0.ssh.forward_agent       =true

    cerebro0.vm.synced_folder      ".",         "/home/cerebro0"
    cerebro0.vm.synced_folder      "./shared", "/mnt/shared"

    #cerebro0.vm.provision       :shell, path: "./shell/cerebro0.sh"

    cerebro0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "git::default"
      chef.add_recipe             "cerebro::default"
    end
  end

# test: vagrant ssh cerebro0, git -v

###############################################################################
###################################    brazos0     ##############################
###############################################################################

  config.vm.define "brazos0" do | brazos0 |
    brazos0.vm.host_name            ="brazos0.calavera.biz"
    brazos0.vm.network               "private_network", ip: "10.0.0.11"
    brazos0.vm.network               "forwarded_port", guest: 22, host: 2011, auto_correct: true
    brazos0.vm.network               "forwarded_port", guest: 80, host: 8011, auto_correct: true
    brazos0.vm.network              "forwarded_port", guest: 8080, host: 9011, auto_correct: true

    brazos0.ssh.forward_agent       =true

    brazos0.vm.synced_folder        ".",         "/home/brazos0"
    brazos0.vm.synced_folder        "./shared", "/mnt/shared"

    brazos0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "git::default"
      chef.add_recipe             "localAnt::default"
      chef.add_recipe             "shared::_junit"
      chef.add_recipe             "java7::default"
      chef.add_recipe             "tomcat::default"
      chef.add_recipe             "brazos::default"
    end
  end

###############################################################################
###################################    espina0     ##############################
###############################################################################

  config.vm.define "espina0" do | espina0 |
    espina0.vm.host_name            ="espina0.calavera.biz"
    espina0.vm.network               "private_network", ip: "10.0.0.12"
    espina0.vm.network               "forwarded_port", guest: 22, host: 2012, auto_correct: true
    espina0.vm.network               "forwarded_port", guest: 80, host: 8012, auto_correct: true
    espina0.vm.network              "forwarded_port", guest: 8080, host: 9012, auto_correct: true
    espina0.vm.network              "forwarded_port", guest: 8081, host: 7012, auto_correct: true

    espina0.ssh.forward_agent        =true

    espina0.vm.synced_folder        ".",         "/home/espina0"
    espina0.vm.synced_folder        "./shared", "/mnt/shared"
    #espina0.vm.provision       :shell, path: "./shell/espina0.sh"

    espina0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "java7::default"
      #chef.add_recipe            "java8::default" reverting to ARtifactory 3.51
      chef.add_recipe             "espina::default"
    end
  end

  # test: x-windows http://10.0.0.12:8081/artifactory, admin/password
  # curl not working
  # artifactory / jenkins config is stored in cookbooks/hombros/files/org.jfrog.hudson.ArtifactoryBuilder.xml
  # select "target repository" in hijoInit setup (defaults to ext-release-local) - this probably will show up in xml export

###############################################################################
###################################    hombros0     ##############################
###############################################################################

  config.vm.define "hombros0" do | hombros0 |
    hombros0.vm.host_name          ="hombros0.calavera.biz"
    hombros0.vm.network             "private_network", ip: "10.0.0.13"
    hombros0.vm.network            "forwarded_port", guest: 22, host: 2013, auto_correct: true
    hombros0.vm.network            "forwarded_port", guest: 80, host: 8013, auto_correct: true
    hombros0.vm.network            "forwarded_port", guest: 8080, host: 9013, auto_correct: true

    hombros0.ssh.forward_agent      =true

    hombros0.vm.synced_folder        ".",         "/home/hombros0"
    hombros0.vm.synced_folder        "./shared", "/mnt/shared"

    #hombros0.vm.provision          :shell, path: "./shell/hombros0.sh"

    hombros0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path           = ["./cookbooks/"]
      chef.add_recipe               "git::default"
      chef.add_recipe               "jenkins::master"
      chef.add_recipe               "hombros::default"
    end

  end

  # Jenkins should appear at http://10.0.0.13:8080

###############################################################################
###################################    manos0     ##############################
###############################################################################

  config.vm.define "manos0" do | manos0 |
    manos0.vm.host_name            ="manos0.calavera.biz"
    manos0.vm.network              "private_network", ip: "10.0.0.14"
    manos0.vm.network              "forwarded_port", guest: 22, host: 2014, auto_correct: true
    manos0.vm.network              "forwarded_port", guest: 80, host: 8014, auto_correct: true
    manos0.vm.network              "forwarded_port", guest: 8080, host: 9014, auto_correct: true

    manos0.ssh.forward_agent        =true

    manos0.vm.synced_folder        ".",         "/home/manos0"
    manos0.vm.synced_folder        "./shared", "/mnt/shared"
    #manos0.vm.provision         :shell, path: "./shell/manos0.sh"

    manos0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "git::default"
      chef.add_recipe             "localAnt::default"
      chef.add_recipe             "java7::default"   #   this is redundant. we already installed this in base and tomcat also installs Java. but won't work w/o it.
      chef.add_recipe             "tomcat::default"
      chef.add_recipe             "shared::_junit"
      chef.add_recipe             "manos::default"
    end
  end

  # test: http://10.0.0.14:8080/MainServlet
  # if cerebro is configured:
  # git add .
  # git commit -m "some message"
  # git push origin master


###############################################################################
###################################    cara0     ##############################
###############################################################################

  config.vm.define "cara0" do | cara0 |
    cara0.vm.host_name              ="cara0.calavera.biz"
    cara0.vm.network                 "private_network", ip: "10.0.0.15"
    cara0.vm.network                 "forwarded_port", guest: 22, host: 2015, auto_correct: true
    cara0.vm.network                 "forwarded_port", guest: 80, host: 8015, auto_correct: true
    cara0.vm.network                "forwarded_port", guest: 8080, host: 9015, auto_correct: true

    cara0.ssh.forward_agent        =true

    cara0.vm.synced_folder          ".",         "/home/cara0"
    cara0.vm.synced_folder          "./shared", "/mnt/shared"
    #cara0.vm.provision       :shell, path: "./shell/cara0.sh"]

    cara0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "java7::default"
      chef.add_recipe             "tomcat::default"
      chef.add_recipe             "cara::default"
    end
  end

    # test: http://10.0.0.15:8080/MainServlet

###############################################################################
###################################    nervios0     ##############################
###############################################################################
# monitoring

  config.vm.define "nervios0" do | nervios0 |
    nervios0.vm.host_name              ="nervios0.calavera.biz"
    nervios0.vm.network                 "private_network", ip: "10.0.0.16"
    nervios0.vm.network                 "forwarded_port", guest: 22, host: 2016, auto_correct: true
    nervios0.vm.network                 "forwarded_port", guest: 80, host: 8016, auto_correct: true
    nervios0.vm.network                 "forwarded_port", guest: 8080, host: 9016, auto_correct: true

    nervios0.ssh.forward_agent        =true

      nervios0.vm.synced_folder         ".", "/home/nervios0"
      nervios0.vm.synced_folder         "./shared", "/mnt/shared"
      #nervios0.vm.provision       :shell, path: "./shell/nervios0.sh"

      nervios0.vm.provision :chef_zero do |chef|
      chef.cookbooks_path =       ["./cookbooks/"]
      #chef.add_recipe             "nervios::default"
    end
  end

###############################################################################
###################################    pies     ##############################
###############################################################################
# monitoring

  config.vm.define "pies" do | pies |

    config.vm.provider :virtualbox do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
      virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    pies.vm.host_name              ="pies.calavera.biz"
    pies.vm.network                 "private_network", ip: "192.168.33.37"
    pies.vm.network                 "forwarded_port", guest: 22, host: 2237, auto_correct: true
    pies.vm.network                 "forwarded_port", guest: 80, host: 8037, auto_correct: true
    pies.vm.network                "forwarded_port", guest: 8080, host: 8137, auto_correct: true

    pies.ssh.forward_agent        =true

      pies.vm.synced_folder         ".", "/home/pies"
      pies.vm.synced_folder         "./shared", "/mnt/shared"
    #nervios.vm.provision       :shell, path: "./shell/pies.sh"

    pies.vm.provision :chef_zero do |chef|
      chef.cookbooks_path =       ["./cookbooks/"]
      #chef.add_recipe             "pies::default"
    end
  end


###############################################################################
###################################    test     ##############################
###############################################################################
# a test machine to try out new things
# not part of the pipeline

  config.vm.define "test" do | test |
    test.vm.host_name              ="test.calavera.biz"
    test.vm.network                 "private_network", ip: "192.168.33.99"
    test.vm.network                 "forwarded_port", guest: 22, host: 2299, auto_correct: true
    test.vm.network                 "forwarded_port", guest: 80, host: 8099, auto_correct: true
    test.vm.network                "forwarded_port", guest: 8080, host: 8199, auto_correct: true

    test.ssh.forward_agent        =true

      test.vm.synced_folder         ".", "/home/test"
      test.vm.synced_folder         "./shared", "/mnt/shared"
    #test.vm.provision       :shell, path: "./shell/test.sh"

    test.vm.provision :chef_zero do |chef|
      chef.cookbooks_path =       ["./cookbooks/"]
      chef.add_recipe             "test::default"
    end
  end
###############################################################################

end
