# do NOT just "vagrant up" this whole cluster. not recommended.
# currently, need to do startup.sh and then vagrant up the machines one by on in this order
#  cerebro, brazos, espina, hombros, manos, cara

# Lab-03 fork for working only with Manos

#Berksfile tweak needed per https://github.com/berkshelf/vagrant-berkshelf/issues/237  **/.git

# dependencies:
  # manos => cerebro
  # manos => hombros
  # hombros => brazos
  # hombros => espina
  # hombros => cerebro
  # cara => espina
#
Vagrant.configure(2) do |config|
  if ARGV[1]=='base'
    config.vm.box = "opscode/temp"
  else
    config.vm.box_url = "/var/vagrant/boxes/opscode-ubuntu-14.04a.box"
    config.vm.box = "opscode-ubuntu-14.04a"  # this box will not be on your machine to start
  end
  config.berkshelf.enabled = true


###############################################################################
###################################    manos     ##############################
###############################################################################

  config.vm.define "manos" do | manos |
    manos.vm.host_name            ="manos.calavera.biz"
    #manos.vm.network              "private_network", ip: "192.168.33.34"  # don't need to specify; we use 127.0.0.1:port for access for this lab
    manos.vm.network              "forwarded_port", guest: 22, host: 2234, auto_correct: true
    manos.vm.network              "forwarded_port", guest: 80, host: 8034
    manos.vm.network              "forwarded_port", guest: 8080, host: 8134

    manos.ssh.forward_agent        =true

    manos.vm.synced_folder        ".",         "/home/manos"
    manos.vm.synced_folder        "./shared", "/mnt/shared"
    #manos.vm.provision         :shell, path: "./shell/manos.sh"

    manos.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "git::default"
      chef.add_recipe             "localAnt::default"
      chef.add_recipe             "java7::default"   #   this is redundant. we already installed this in base and tomcat also installs Java. but won't work w/o it.
      chef.add_recipe             "tomcat::default"
      chef.add_recipe             "shared::_junit"
      chef.add_recipe             "manos::default"
    end
  end

  # test from main host: curl http://127.0.0.1:8134/MainServlet
  # substitute your appropriate port for 8134


 end
