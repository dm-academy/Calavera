#! /bin/bash
#this script should be sourced by all provisioning scripts
# it is NOT idempotent and will result in duplicate keys in authorized_keys if run a 2nd time
# in this lower security approach there is just one key pair used across every node
# we don't want a permanent set for whole cluster so it can't go in BakeCalavera.sh
# (tempting but we need at least adequate security)
# nor do we want keys in github, so both .ssh and rsa* are in gitignore.

# Ok here is the business rule
# ssh.sh is run out of calavera::default chef recipe
# 
# and checks that the key pair exists in /mnt/shared/keys (this directory must be shared across the cluster)
# generates if it does not
# force copies keys to ~/.ssh
# (to reset all keys delete /mnt/shared/keys and kitchen/vagrant destroy/up)
# 

echo configuring ssh

mkdir -p /mnt/shared/keys  # -p = no error if it exists (this part is idempotent b/c we don't know if another node has already keygen'd)
chown vagrant /mnt/shared/keys

if [[ $(ls /mnt/shared/keys) !=  *id_rsa[^\.]* ]] && \
   [[ $(ls /mnt/shared/keys) !=  *id_rsa.pub   ]] #   either shared key or private key are missing in /mnt/shared/keys
   then
       echo missing key, regenerating both shared and private    
       sudo ssh-keygen -q -t rsa -f "/mnt/shared/keys/id_rsa" -P "" \
        -C "*** Host key auto-generated on Vagrant provisioning by node $HOSTNAME on "$(date +%F)" "$(date +%T)" UTC ***"
    #regenerate both
    sudo chown vagrant /mnt/shared/keys/*
fi

cp -f /mnt/shared/keys/id_rsa* ~/.ssh # copy both to user (vagrant for now) .ssh
echo "# CALAVERA: This file was updated by the $HOSTNAME provisioning process" >> /home/vagrant/.ssh/authorized_keys  
cat /mnt/shared/keys/id_rsa.pub >> ~/.ssh/authorized_keys   # not idempotent; script intended only to be run on initial vagrant up
chown vagrant /home/vagrant/.ssh/* 
