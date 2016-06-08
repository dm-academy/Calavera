# Vagrantfile template
# you need to replace all 1 with digit 1-9
# hostnames are hard coded in following locations:
# cerebro|files|post-receive
# manos::default
#
# do NOT just "vagrant up" this whole cluster. not recommended.
# currently, need to do startup.sh and then vagrant up the machines one by on in this order
#  cerebro, brazos, espina, hombros, manos, cara

# dependencies:
  # manos => cerebro
  # manos => hombros
  # hombros => brazos
  # hombros => espina
  # hombros => cerebro
  # cara => espina
  
    module OS
      def OS.windows?
          (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      end
      def OS.mac?
          (/darwin/ =~ RUBY_PLATFORM) != nil
      end
      def OS.unix?
          !OS.windows?
      end
      def OS.linux?
          OS.unix? and not OS.mac?
      end
  end


  if OS.windows?
      puts "Vagrant launched from windows."
  elsif OS.mac?
      puts "Vagrant launched from mac."
  elsif OS.unix?
      puts "Vagrant launched from linux/unix."
  elsif OS.linux?
      puts "Vagrant launched from linux."
  else
      puts "Unsupported platform for Calavera."
  end
  
  Vagrant.configure(2) do |config|



  if ARGV[1]=='base'
    config.vm.box = "opscode/temp"
  else    # if this errors, you need startup.sh run
    if OS.windows?
      config.vm.box = "opscode-ubuntu-14.04a"  # does not support multi-pipeline yet. box stashed local to user.
    else    
      # pull from common location. Supports multiple pipelines.
      config.vm.box = "opscode-ubuntu-14.04a" 
      #config.vm.box_url = "/var/vagrant/boxes/opscode-ubuntu-14.04a.box" 
    end


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
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "base::default"  # java, curl and tree
      chef.add_recipe               "base::_hosts"
      chef.add_recipe               "base::_ssh"

    end
  end

###############################################################################
###################################    cerebro1   ##############################
###############################################################################

  config.vm.define "cerebro1" do | cerebro1 |
    cerebro1.vm.host_name           ="cerebro1.calavera.biz"
    cerebro1.vm.network             "private_network", ip: "10.1.0.10"
    cerebro1.vm.network            "forwarded_port", guest: 22, host: 2110, auto_correct: true
    cerebro1.vm.network            "forwarded_port", guest: 80, host: 8110, auto_correct: true
    cerebro1.vm.network             "forwarded_port", guest: 8080, host: 9110, auto_correct: true

    cerebro1.ssh.forward_agent       =true

    cerebro1.vm.synced_folder      ".",         "/home/cerebro1"
    cerebro1.vm.synced_folder      "./shared", "/mnt/shared"

    #cerebro1.vm.provision       :shell, path: "./shell/cerebro1.sh"

    cerebro1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path           = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "git::default"
      chef.add_recipe               "cerebro::default"
    end
  end

# test: vagrant ssh cerebro1, git -v

###############################################################################
###################################    brazos1     ##############################
###############################################################################

  config.vm.define "brazos1" do | brazos1 |
    brazos1.vm.host_name            ="brazos1.calavera.biz"
    brazos1.vm.network               "private_network", ip: "10.1.0.11"
    brazos1.vm.network               "forwarded_port", guest: 22, host: 2111, auto_correct: true
    brazos1.vm.network               "forwarded_port", guest: 80, host: 8111, auto_correct: true
    brazos1.vm.network              "forwarded_port", guest: 8080, host: 9111, auto_correct: true

    brazos1.ssh.forward_agent       =true

    brazos1.vm.synced_folder        ".",         "/home/brazos1"
    brazos1.vm.synced_folder        "./shared", "/mnt/shared"

    brazos1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "git::default"
      chef.add_recipe               "localAnt::default"
      chef.add_recipe               "shared::_junit"
      chef.add_recipe               "java7::default"
      chef.add_recipe               "localTomcat::v8"
      chef.add_recipe               "brazos::default"
    end
  end

###############################################################################
###################################    espina1     ##############################
###############################################################################

  config.vm.define "espina1" do | espina1 |
    espina1.vm.host_name            ="espina1.calavera.biz"
    espina1.vm.network               "private_network", ip: "10.1.0.12"
    espina1.vm.network               "forwarded_port", guest: 22, host: 2112, auto_correct: true
    espina1.vm.network               "forwarded_port", guest: 80, host: 8112, auto_correct: true
    espina1.vm.network              "forwarded_port", guest: 8080, host: 9112, auto_correct: true
    espina1.vm.network              "forwarded_port", guest: 8081, host: 7112, auto_correct: true

    espina1.ssh.forward_agent        =true

    espina1.vm.synced_folder        ".",         "/home/espina1"
    espina1.vm.synced_folder        "./shared", "/mnt/shared"
    #espina1.vm.provision       :shell, path: "./shell/espina1.sh"

    espina1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "java7::default"
      #chef.add_recipe              "java8::default" reverting to ARtifactory 3.51
      chef.add_recipe               "espina::default"
    end
  end

  # test: x-windows http://10.1.0.12:8081/artifactory, admin/password
  # curl not working
  # artifactory / jenkins config is stored in cookbooks/hombros/files/org.jfrog.hudson.ArtifactoryBuilder.xml
  # select "target repository" in hijoInit setup (defaults to ext-release-local) - this probably will show up in xml export

###############################################################################
###################################    hombros1     ##############################
###############################################################################

  config.vm.define "hombros1" do | hombros1 |
    hombros1.vm.host_name          ="hombros1.calavera.biz"
    hombros1.vm.network             "private_network", ip: "10.1.0.13"
    hombros1.vm.network            "forwarded_port", guest: 22, host: 2113, auto_correct: true
    hombros1.vm.network            "forwarded_port", guest: 80, host: 8113, auto_correct: true
    hombros1.vm.network            "forwarded_port", guest: 8080, host: 9113, auto_correct: true

    hombros1.ssh.forward_agent      =true

    hombros1.vm.synced_folder        ".",         "/home/hombros1"
    hombros1.vm.synced_folder        "./shared", "/mnt/shared"

    #hombros1.vm.provision          :shell, path: "./shell/hombros1.sh"

    hombros1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path           = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "git::default"
      #chef.add_recipe               "jenkins::master"
      chef.add_recipe               "localJenkins::default"
      chef.add_recipe               "hombros::default"
    end

  end

  # Jenkins should appear at http://10.1.0.13:8080

###############################################################################
###################################    manos1    ##############################
###############################################################################

  config.vm.define "manos1" do | manos1 |
    manos1.vm.host_name            ="manos1.calavera.biz"
    manos1.vm.network              "private_network", ip: "10.1.0.14"
    manos1.vm.network              "forwarded_port", guest: 22, host: 2114, auto_correct: true
    manos1.vm.network              "forwarded_port", guest: 80, host: 8114, auto_correct: true
    manos1.vm.network              "forwarded_port", guest: 8080, host: 9114, auto_correct: true

    manos1.ssh.forward_agent        =true

    manos1.vm.synced_folder        ".",         "/home/manos1"
    manos1.vm.synced_folder        "./shared", "/mnt/shared"
    #manos1.vm.provision         :shell, path: "./shell/manos1.sh"

    manos1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "git::default"
      chef.add_recipe               "localAnt::default"
      chef.add_recipe               "java7::default"   #   this is redundant. we already installed this in base and tomcat also installs Java. but won't work w/o it.
      chef.add_recipe               "localTomcat::v8"
      chef.add_recipe               "shared::_junit"
      chef.add_recipe               "manos::default"
    end
  end

  # test: http://10.1.0.14:8080/MainServlet
  # if cerebro is configured:
  # cd /home/hijo   #make a change
  # git add .
  # git commit -m "some message"
  # git push origin master


###############################################################################
###################################    cara1     ##############################
###############################################################################

  config.vm.define "cara1" do | cara1 |
    cara1.vm.host_name              ="cara1.calavera.biz"
    cara1.vm.network                 "private_network", ip: "10.1.0.15"
    cara1.vm.network                 "forwarded_port", guest: 22, host: 2115, auto_correct: true
    cara1.vm.network                 "forwarded_port", guest: 80, host: 8115, auto_correct: true
    cara1.vm.network                "forwarded_port", guest: 8080, host: 9115, auto_correct: true

    cara1.ssh.forward_agent        =true

    cara1.vm.synced_folder          ".",         "/home/cara1"
    cara1.vm.synced_folder          "./shared", "/mnt/shared"
    #cara1.vm.provision       :shell, path: "./shell/cara1.sh"]

    cara1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "java7::default"
      chef.add_recipe               "localTomcat::v8"
      chef.add_recipe               "cara::default"
    end
  end

    # test: http://10.1.0.15:8080/MainServlet

###############################################################################
###################################    nervios1     ##############################
###############################################################################
# monitoring

  config.vm.define "nervios1" do | nervios1 |
    nervios1.vm.host_name              ="nervios1.calavera.biz"
    nervios1.vm.network                 "private_network", ip: "10.1.0.16"
    nervios1.vm.network                 "forwarded_port", guest: 22, host: 2116, auto_correct: true
    nervios1.vm.network                 "forwarded_port", guest: 80, host: 8116, auto_correct: true
    nervios1.vm.network                 "forwarded_port", guest: 8080, host: 9116, auto_correct: true

    nervios1.ssh.forward_agent        =true

      nervios1.vm.synced_folder         ".", "/home/nervios1"
      nervios1.vm.synced_folder         "./shared", "/mnt/shared"
      #nervios1.vm.provision       :shell, path: "./shell/nervios1.sh"

      nervios1.vm.provision :chef_zero do |chef|
      chef.cookbooks_path =       ["./cookbooks/"]
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"

      #chef.add_recipe             "nervios::default"
    end
  end

# test: http://10.1.0.16/nagios

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
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
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
      chef.data_bags_path           = ["./data_bags/"]
      chef.nodes_path               = ["./nodes/"]
      chef.roles_path               = ["./roles/"]
      chef.add_recipe               "shared::_apt-update"
      chef.add_recipe               "tomcat::default"
      chef.add_recipe             "test::default"
    end
  end
###############################################################################

end
