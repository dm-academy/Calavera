
###############################################################################
#############################    ANT  ######################################
###############################################################################
#
# this is a "wrapper" cookbook. note the presence of an attributes file 

# include_recipe "ant::default"   # couldn't use this, insisted on installing its own Java

# this script is not idempotent and I have mixed feelings about making it so.
# what if Ant is corrupted? can't test for a perfect install
# downloading and reinstallilng is not that costly

#execute echo "installing Ant"
remote_file "/opt/apache-ant-1.9.5-bin.tar.gz" do
    source 'http://mirror.nexcess.net/apache//ant/binaries/apache-ant-1.9.5-bin.tar.gz'
end

bash 'install Ant' do
  cwd '/opt'
  code <<-EOH
    tar xzf apache-ant-1.9.5-bin.tar.gz
    rm -f apache-ant-1.9.5-bin.tar.gz
    echo export ANT_HOME=/opt/apache-ant-1.9.5 > /etc/profile.d/ant.sh  # not idempotent, will continue adding repeated lines
    echo export ANT_HOME=/usr/share/apache-ant-1.9.5 >> ~/.bashrc       # need to write a simple grep test
    mkdir -p /home/jenkins
    echo export ANT_HOME=/usr/share/apache-ant-1.9.5 >> /home/jenkins/.bashrc
    EOH
end

link "/usr/local/bin/ant" do
  to "/opt/apache-ant-1.9.5/bin/ant"
end
