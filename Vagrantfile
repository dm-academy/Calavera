# Lab-03 fork for working only with Manos

#Berksfile tweak needed per https://github.com/berkshelf/vagrant-berkshelf/issues/237  **/.git

Vagrant.configure(2) do |config|
  if ARGV[1]=='base'
    config.vm.box = "opscode/temp"
  else
    config.vm.box_url = "/var/vagrant/boxes/opscode-ubuntu-14.04a.box"  # need to run startup.sh on your machine
    config.vm.box = "opscode-ubuntu-14.04a" 
  end
  config.berkshelf.enabled = true


###############################################################################
###################################    manos     ##############################
###############################################################################

  config.vm.define "manos" do | manos |
    manos.vm.host_name            ="manos.calavera.biz"
    #manos.vm.network              "private_network", ip: "192.168.33.34"  # don't need to specify; we use 127.0.0.1:port for access for this lab
    manos.vm.network              "forwarded_port", guest: 22, host: 2234, auto_correct: true
    manos.vm.network              "forwarded_port", guest: 80, host: 8034, auto_correct: true
    manos.vm.network              "forwarded_port", guest: 8080, host: 8134, auto_correct: true
    
    # the forwarded ports will most likely change if multiple students are running.
    # They need to make note of what the port was corrected to, or use vboxmanage as described in the lab to determine. 

    manos.ssh.forward_agent        =true

    manos.vm.synced_folder        ".",         "/home/manos"
    manos.vm.synced_folder        "./shared", "/mnt/shared"
    #manos.vm.provision         :shell, path: "./shell/manos.sh"

    manos.vm.provision :chef_zero do |chef|
      chef.cookbooks_path         = ["./cookbooks/"]
      chef.add_recipe             "git::default"
      chef.add_recipe             "localAnt::default"
      chef.add_recipe             "java7::default"  
      chef.add_recipe             "tomcat::default"
      chef.add_recipe             "shared::_junit"
      chef.add_recipe             "manos::default"
    end
  end

  # test from main host: curl http://127.0.0.1:8134/MainServlet
  # substitute appropriate port for 8134

 end
