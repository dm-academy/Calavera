# Main issue right now is that I have baked Java and Tomcat into the "calavera" box image.
# Vagrant up will not work unless this is done first.
# Currently using 32-bit Ubuntu 14
# I need to create a script to automatically bake this. 

# to do: identities
# Developer: "hijodev"
# Tomcat
# Sysadmin: "jefe"
# Let's get Chef running for this


Vagrant.configure(2) do |config|

	config.vm.box = "calavera"
	
	
###############################################################################
###################################    PIERNAS   ##############################
###############################################################################

	config.vm.define "piernas" do | piernas |
		piernas.vm.host_name		="piernas"	
		piernas.vm.network 		"private_network", ip: "192.168.33.10"
		piernas.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		piernas.vm.network 		"forwarded_port", guest: 22, host: 2200, auto_correct: true
		piernas.vm.network 		"forwarded_port", guest: 80, host: 8080
		piernas.vm.network		"forwarded_port", guest: 8080, host: 8180
		piernas.vm.synced_folder "./piernas", "/home/calavera"
		piernas.vm.synced_folder "./calavera-shared", "/mnt/public"
		piernas.vm.provision 	:shell, 	path: "./piernas/piernas.sh" 
	end	

###############################################################################
###################################    CARA   #################################
###############################################################################

	config.vm.define "cara" do | cara |
		cara.vm.host_name			="cara"
	   cara.vm.network 			"private_network", ip: "192.168.33.11"
		cara.vm.network 			"forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: true
		cara.vm.network 			"forwarded_port", guest: 22, host: 2201, auto_correct: true		
		cara.vm.network 			"forwarded_port", guest: 80, host: 8081
		cara.vm.network			"forwarded_port", guest: 8080, host: 8181
		cara.vm.synced_folder  	"./cara", "/home/calavera"
		cara.vm.synced_folder 	"./calavera-shared", "/mnt/public"
		cara.vm.provision 		:shell, path: "./cara/cara.sh" 
	end
	
###############################################################################
###################################    BRAZOS   ###############################
###############################################################################

	config.vm.define "brazos" do | brazos |
		brazos.vm.host_name		="brazos"
		brazos.vm.network 		"private_network", ip: "192.168.33.12"
		brazos.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		brazos.vm.network 		"forwarded_port", guest: 22, host: 2202, auto_correct: true		
		brazos.vm.network 		"forwarded_port", guest: 80, host: 8082
		brazos.vm.network			"forwarded_port", guest: 8080, host: 8182
		brazos.vm.synced_folder "./brazos", "/home/calavera"
		brazos.vm.synced_folder 	"./calavera-shared", "/mnt/public"		
		brazos.vm.provision 		:shell, path: "./brazos/brazos.sh"
	end

###############################################################################
###################################    ESPINA   ###############################
###############################################################################

# init bare repository
# install package repository
# configure brazos as slave to espina - this build is dependent on brazos
# jenkins I think will push the slave.jar down, so we're fine there
# configure jenkins to monitor the repo and kick off build on brazos....

	config.vm.define "espina" do | espina |
		espina.vm.host_name		="espina"
		espina.vm.network 		"private_network", ip: "192.168.33.13"
		espina.vm.network 		:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		espina.vm.network 		"forwarded_port", guest: 22, host: 2203, auto_correct: true		
		espina.vm.network 		"forwarded_port", guest: 80, host: 8083
		espina.vm.network			"forwarded_port", guest: 8080, host: 8183
		espina.vm.synced_folder "./espina", "/home/calavera"
		espina.vm.synced_folder "./calavera-shared", "/mnt/public"	
		espina.vm.provision 		:shell, path: "./espina/espina.sh"
	end
	
	
###############################################################################
###################################    MANOS    ###############################
###############################################################################	
	
# this concludes with a git push that kicks off the jenkins build on brazos that deploys to cara
# have to push to the bare repo
# that means this build is dependent on espina and brazos
	
	config.vm.define "manos" do | manos |
		manos.vm.host_name 		="manos"
		manos.vm.network			"private_network", ip: "192.168.33.14"
		manos.vm.network 			:forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
		manos.vm.network 			"forwarded_port", guest: 22, host: 2204, auto_correct: true	
		manos.vm.network 			"forwarded_port", guest: 80, host: 8084
		manos.vm.network			"forwarded_port", guest: 8080, host: 8184
		manos.vm.synced_folder 	"./manos", "/home/calavera"
		manos.vm.synced_folder 	"./calavera-shared", "/mnt/public"	
		manos.vm.provision 		:shell, path: "./manos/manos.sh"
	end

end
