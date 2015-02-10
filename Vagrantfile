#Berksfile tweak needed per https://github.com/berkshelf/vagrant-berkshelf/issues/237  **/.git


Vagrant.configure(2) do |config|

	config.vm.box = "ubuntu/trusty64"  # updated only with VirtualBox addin at this point
        config.berkshelf.enabled = true
#        config.vm.provider :virtualbox do |virtualbox|
#          virtualbox.customize ["modifyvm", :id, "--memory", "4096"]   # e.g. for Chef Server
#          virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
#        end
        
        
###############################################################################
###################################    cerebro   ##############################
###############################################################################

	config.vm.define "cerebro" do | cerebro |
		cerebro.vm.host_name		="cerebro.calavera.biz"	
		cerebro.vm.network 		"private_network", ip: "192.168.33.30"
		cerebro.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		cerebro.vm.network 		"forwarded_port", guest: 22, host: 2230, auto_correct: true
		cerebro.vm.network 		"forwarded_port", guest: 80, host: 8030
		cerebro.vm.network		"forwarded_port", guest: 8080, host: 8130
                cerebro.vm.synced_folder        ".", "/home/cerebro"
                cerebro.vm.synced_folder        "./shared", "/mnt/shared"                
		#cerebro.vm.provision 	    :shell, path: "./shell/cerebro.sh"
		cerebro.vm.provision :chef_zero do |chef|
                    chef.cookbooks_path = ["./cookbooks/"]
                    chef.add_recipe "shared::default"                    
                    chef.add_recipe "git::default"
                    chef.add_recipe "cerebro::default"
                end
	end

###############################################################################
###################################    brazos     ##############################
###############################################################################

	config.vm.define "brazos" do | brazos |
		brazos.vm.host_name		="brazos.calavera.biz"	
		brazos.vm.network 		"private_network", ip: "192.168.33.31"
		brazos.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		brazos.vm.network 		"forwarded_port", guest: 22, host: 2231, auto_correct: true
		brazos.vm.network 		"forwarded_port", guest: 80, host: 8031
		brazos.vm.network		"forwarded_port", guest: 8080, host: 8131
                brazos.vm.synced_folder           ".", "/home/brazos"
                brazos.vm.synced_folder           "./shared", "/mnt/shared"                
		#brazos.vm.provision 	    :shell, path: "./shell/brazos.sh"
		brazos.vm.provision :chef_zero do |chef|
                    chef.cookbooks_path = ["./cookbooks/"]
                    chef.add_recipe "shared::default" 
		    chef.add_recipe "java::default"
                    chef.add_recipe "ant::default"
                    chef.add_recipe "tomcat::default"
                    chef.add_recipe "shared::_junit"
                    chef.add_recipe "brazos::default"
                end
	end

###############################################################################
###################################    espina     ##############################
###############################################################################

	config.vm.define "espina" do | espina |
		espina.vm.host_name		="espina.calavera.biz"	
		espina.vm.network 		"private_network", ip: "192.168.33.32"
		espina.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		espina.vm.network 		"forwarded_port", guest: 22, host: 2232, auto_correct: true
		espina.vm.network 		"forwarded_port", guest: 80, host: 8032
		espina.vm.network		"forwarded_port", guest: 8080, host: 8132
                espina.vm.synced_folder           ".", "/home/espina"
                espina.vm.synced_folder           "./shared", "/mnt/shared"                
		#espina.vm.provision 	    :shell, path: "./shell/espina.sh"
		espina.vm.provision :chef_zero do |chef|
		    
                    chef.cookbooks_path = ["./cookbooks/"]
		    chef.add_recipe "shared::default"
                    chef.add_recipe "java::default"
                    chef.add_recipe "espina::default"
                end
	end
	
###############################################################################
###################################    hombros     ##############################
###############################################################################

	config.vm.define "hombros" do | hombros |
		hombros.vm.host_name		="hombros.calavera.biz"	
		hombros.vm.network 		"private_network", ip: "192.168.33.33"
		hombros.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		hombros.vm.network 		"forwarded_port", guest: 22, host: 2233, auto_correct: true
		hombros.vm.network 		"forwarded_port", guest: 80, host: 8033
		hombros.vm.network		"forwarded_port", guest: 8080, host: 8133
                hombros.vm.synced_folder           ".", "/home/hombros"
                hombros.vm.synced_folder           "./shared", "/mnt/shared"                
		#hombros.vm.provision 	    :shell, path: "./shell/hombros.sh"
		hombros.vm.provision :chef_zero do |chef|
		    
                    chef.cookbooks_path = ["./cookbooks/"]
		    chef.add_recipe "shared::default"
                    chef.add_recipe "git::default"		    
                    chef.add_recipe "jenkins::master"
                    chef.add_recipe "hombros::default"
                end
	end
        
###############################################################################
###################################    manos     ##############################
###############################################################################

	config.vm.define "manos" do | manos |
		manos.vm.host_name		="manos.calavera.biz"	
		manos.vm.network 		"private_network", ip: "192.168.33.34"
		manos.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		manos.vm.network 		"forwarded_port", guest: 22, host: 2234, auto_correct: true
		manos.vm.network 		"forwarded_port", guest: 80, host: 8034
		manos.vm.network		"forwarded_port", guest: 8080, host: 8134
                manos.vm.synced_folder           ".", "/home/manos"
                manos.vm.synced_folder           "./shared", "/mnt/shared"                
		#manos.vm.provision 	    :shell, path: "./shell/manos.sh"
		manos.vm.provision :chef_zero do |chef|
                    chef.cookbooks_path = ["./cookbooks/"]
		    chef.add_recipe "shared::default"
                    chef.add_recipe "git::default"
                    chef.add_recipe "java::default"
                    chef.add_recipe "ant::default"
                    chef.add_recipe "tomcat::default"
                    chef.add_recipe "shared::_junit"
                    chef.add_recipe "manos::default"
                end
	end
	
###############################################################################
###################################    cara     ##############################
###############################################################################

	config.vm.define "cara" do | cara |
		cara.vm.host_name		="cara.calavera.biz"	
		cara.vm.network 		"private_network", ip: "192.168.33.35"
		cara.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		cara.vm.network 		"forwarded_port", guest: 22, host: 2235, auto_correct: true
		cara.vm.network 		"forwarded_port", guest: 80, host: 8035
		cara.vm.network		"forwarded_port", guest: 8080, host: 8135
                cara.vm.synced_folder           ".", "/home/cara"
                cara.vm.synced_folder           "./shared", "/mnt/shared"                
		#cara.vm.provision 	    :shell, path: "./shell/cara.sh"
		cara.vm.provision :chef_zero do |chef|
                    chef.cookbooks_path = ["./cookbooks/"]
		    chef.add_recipe "shared::default"
                    chef.add_recipe "java::default"
                    chef.add_recipe "tomcat::default"
                    chef.add_recipe "cara::default"
                end
	end
end

