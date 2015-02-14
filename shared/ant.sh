###############################################################################
#############################    ANT   ########################################
###############################################################################

#install ant on ubuntu 14
echo "installing Ant..."
#yum -y install ant   # Yum install of ant was not working correctly. outdated & other issues.
cd /usr/share
wget --quiet http://mirror.nexcess.net/apache//ant/binaries/apache-ant-1.9.4-bin.tar.gz
tar xzf apache-ant-1.9.4-bin.tar.gz >/dev/null
rm -f apache-ant-1.9.4-bin.tar.gz

## tried to put these in /etc/profile.d but 1) didn't work for "non-login shells"
## (even shells I was logging in with) and 2) found advice against it
#echo "export ANT_HOME=\"/usr/share/apache-ant-1.9.4\"" >> ~/.bashrc
#echo "export PATH=\"/usr/share/apache-ant-1.9.4/bin:\"$PATH" >> ~/.bashrc

rm -rf /etc/profile.d/ant.sh
echo export ANT_HOME=/usr/share/apache-ant-1.9.4\ > /etc/profile.d/ant.sh
echo export PATH=/usr/share/apache-ant-1.9.4/bin:'$PATH'>>/etc/profile.d/ant.sh
echo export ANT_HOME=/usr/share/apache-ant-1.9.4\ >> ~/.bashrc
echo export PATH=/usr/share/apache-ant-1.9.4/bin:'$PATH'>> ~/.bashrc

chmod +x /etc/profile.d/ant.sh
cd /etc/profile.d
source ant.sh

