###############################################################################
#############################    ANT   ########################################
###############################################################################

# get the variables from the variable file.
. ../env.sh

#install ant on ubuntu 14
echo "installing Ant..."
#yum -y install ant   # Yum install of ant was not working correctly. outdated & other issues.
cd /usr/share
wget --quiet $ANT_MIRROR/$ANT_VERSION-bin.tar.gz
tar xzf $ANT_VERSION-bin.tar.gz >/dev/null
rm -f $ANT_VERSION-bin.tar.gz

## tried to put these in /etc/profile.d but 1) didn't work for "non-login shells"
## (even shells I was logging in with) and 2) found advice against it
#echo "export ANT_HOME=\"/usr/share/$ANT_VERSION\"" >> ~/.bashrc
#echo "export PATH=\"/usr/share/$ANT_VERSION/bin:\"$PATH" >> ~/.bashrc

rm -rf /etc/profile.d/ant.sh
echo export ANT_HOME=/usr/share/$ANT_VERSION\ > /etc/profile.d/ant.sh
echo export PATH=/usr/share/$ANT_VERSION/bin:'$PATH'>>/etc/profile.d/ant.sh
echo export ANT_HOME=/usr/share/$ANT_VERSION\ >> ~/.bashrc
echo export PATH=/usr/share/$ANT_VERSION/bin:'$PATH'>> ~/.bashrc

chmod +x /etc/profile.d/ant.sh
cd /etc/profile.d
source ant.sh
