# this script should be sourced by all provisioning scripts
# every host should have a unique key pair created upon initial provisioning
# we don't want just one for whole cluster so it can't go in BakeCalavera.sh

echo -e  'y\n'|ssh-keygen -q -t rsa -f id_rsa_$HOSTNAME -P "" \
    -C "***Key auto-generated on Vagrant provisioning for Calavera project node $HOSTNAME on "\
    $(date +%F)" "$(date +%T)" UTC ***"

