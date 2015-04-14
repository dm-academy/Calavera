#!/bin/bash

# install otrs
apt-get -y update --fix-missing && apt-get -y upgrade

apt-get -y install libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl \
    libnet-ldap-perl libio-socket-ssl-perl libpdf-api2-perl libdbd-mysql-perl libsoap-lite-perl \
    libgd-text-perl libtext-csv-xs-perl libjson-xs-perl libgd-graph-perl libapache-dbi-perl

wget https://www.otrs.com/download-thank-you/thank-you-downloading-otrs-software/?download=/otrs-4.0.7.tar.gz

shell> tar xzf /tmp/otrs-x.x.x.tar.gz
shell> mv otrs-x.x.x /opt/otrs

perl /opt/otrs/bin/otrs.CheckModules.pl

apt-get install -y libarchive-zip-perl libcrypt-eksblowfish-perl libtemplate-perl libyaml-libyaml-perl

useradd -d /opt/otrs/ -c 'OTRS user' otrs
usermod -G www-data otrs
cd /opt/otrs/
cp Kernel/Config.pm.dist Kernel/Config.pm
cp Kernel/Config/GenericAgent.pm.dist Kernel/Config/GenericAgent.pm

perl -cw /opt/otrs/bin/cgi-bin/index.pl # test grep syntax OK
apt-get -y install apache2 libapache2-mod-perl2

cp /opt/otrs/scripts/apache2-httpd.include.conf otrs.conf
/etc/init.d/apache2 restart

bin/otrs.SetPermissions.pl --web-group=www-data