#!/bin/bash
# itop prereqs

apt-get -y update --fix-missing && apt-get -y upgrade

#currently requires interactive
#debconf-set-selections <<< 'mysql-server mysql-server/root_password password  '
#debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password  '

apt-get -y install lamp-server^
apt-get -y install php5-ldap php5-mcrypt
apt-get -y install graphviz

# call wait 10?

cd /tmp
wget http://downloads.sourceforge.net/project/itop/itop/2.1.0/iTop-2.1.0-2127.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fitop%2Ffiles%2F&ts=1429044402&use_mirror=softlayer-dal

mv iTop* itopcurr
jar -xvf itopcurr
mkdir /var/www/html/itop

cp -R web/* /var/www/html/itop

chmod -R 777 /var/www/html/itop   # gotta narrow this down

/etc/init.d/apache2 restart

#login to http://192.168.33.37/itop
