#!/bin/bash

# install otrs
apt-get -y update --fix-missing && apt-get -y upgrade

apt-get install libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl \
    libnet-ldap-perl libio-socket-ssl-perl libpdf-api2-perl libdbd-mysql-perl libsoap-lite-perl \
    libgd-text-perl libtext-csv-xs-perl libjson-xs-perl libgd-graph-perl libapache-dbi-perl

wget https://www.otrs.com/download-thank-you/thank-you-downloading-otrs-software/?download=/otrs-4.0.7.tar.gz
