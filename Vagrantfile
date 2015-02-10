#Berksfile tweak needed per https://github.com/berkshelf/vagrant-berkshelf/issues/237  **/.git


Vagrant.configure(2) do |config|

	config.vm.box = "ubuntu/trusty64"  # updated only with VirtualBox addin at this point
        config.berkshelf.enabled = true
#        config.vm.provider :virtualbox do |virtualbox|
#          virtualbox.customize ["modifyvm", :id, "--memory", "4096"]   # e.g. for Chef Server
#          virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
#        end
        
###############################################################################
###################################    manos     ##############################
###############################################################################

	config.vm.define "manos" do | manos |
		manos.vm.host_name		="manos.calavera.biz"	
		manos.vm.network 		"private_network", ip: "192.168.33.40"
		manos.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		manos.vm.network 		"forwarded_port", guest: 22, host: 2230, auto_correct: true
		manos.vm.network 		"forwarded_port", guest: 80, host: 8030
		manos.vm.network		"forwarded_port", guest: 8080, host: 8130
                manos.vm.synced_folder           ".", "/home/manos"
                manos.vm.synced_folder           "./files", "/mnt/public"                
		#manos.vm.provision 	    :shell, path: "./shell/manos.sh"
		manos.vm.provision :chef_zero do |chef|
                    chef.cookbooks_path = ["./cookbooks/"]
                    chef.add_recipe "git::default"
                    chef.add_recipe "java::default"
                    chef.add_recipe "ant::default"
                    chef.add_recipe "tomcat::default"
                    chef.add_recipe "shared::_junit"
                    chef.add_recipe "manos::default"
                  #chef.roles_path = "./chef/roles"
                end
	end
end

