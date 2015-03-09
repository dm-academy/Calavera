
sudo apt-get -y install apache2
sudo apt-get -y install mysql-server mysql-client
sudo apt-get -y install php5 php5-mysql libapache2-mod-php5
sudo apt-get -y install phpmyadmin

sudo apt-get -y install build-essential libgd2-xpm-dev apache2-utils

sudo useradd -m nagios
sudo passwd nagios

sudo groupadd nagcmd && sudo usermod -a -G nagcmd nagios && sudo usermod -a -G nagcmd www-data

cd /home/nagios

wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.8.tar.gz

wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz

tar xzf nagios-4.0.8.tar.gz

cd nagios-4.0.8

sudo ./configure --with-command-group=nagcmd
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode

#sudo make install-webconf

sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-enabled/nagios.conf

sudo ls -l /etc/apache2/sites-enabled/

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo service apache2 restart

cd /home/nagios

tar xzf nagios-plugins-2.0.3.tar.gz

cd nagios-plugins-2.0.3

sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios

sudo make

sudo make install

#sudo nano /usr/local/nagios/etc/objects/contacts.cfg
#sudo nano /etc/apache2/sites-enabled/nagios.conf

sudo a2enmod rewrite && sudo a2enmod cgi

sudo service apache2 restart

sudo service nagios start
sudo ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios