
###############################################################################
#############################    ANT  ######################################
###############################################################################
#
# this is a "wrapper" cookbook. note the presence of an attributes file

# include_recipe "ant::default"   # couldn't use this, insisted on installing its own Java

# this script is not idempotent and I have mixed feelings about making it so.
# what if Ant is corrupted? can't test for a perfect install
# downloading and reinstallilng is not that costly

ENV['ANT_VERSION'] = "apache-ant-1.9.6"
ENV['ANT_MIRROR'] = "http://mirror.nexcess.net/apache//ant/binaries/"

#execute echo "installing Ant"
remote_file "/opt/" + ENV['ANT_VERSION'] + "-bin.tar.gz" do
    source ENV['ANT_MIRROR'] + ENV['ANT_VERSION'] + '-bin.tar.gz'
end

bash 'install Ant' do
  cwd '/opt'
  code <<-EOH
    tar xzf $ANT_VERSION-bin.tar.gz
    rm -f $ANT_VERSION-bin.tar.gz
    echo export ANT_HOME=/opt/$ANT_VERSION > /etc/profile.d/ant.sh  # not idempotent, will continue adding repeated lines
    echo export ANT_HOME=/usr/share/$ANT_VERSION >> ~/.bashrc       # need to write a simple grep test
    mkdir -p /home/jenkins
    echo export ANT_HOME=/usr/share/$ANT_VERSION >> /home/jenkins/.bashrc
    EOH
end

link "/usr/local/bin/ant" do
  to "/opt/" + ENV['ANT_VERSION'] + "/bin/ant"
end
