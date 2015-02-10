
###############################################################################
#############################    JAVA  7 ######################################
###############################################################################
#
#execute echo "installing Java 7"
#remote_file "/mnt/public/jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz" do
#    source ''
#end
#
#
#cookbook_file 'jdk-7u40-fcs-bin-b40-linux-x64-16_aug_2013.tar.gz' do
#    path '/usr/lib/jvm'
#    user "root"
#    group "root"
#    action :create
#end
#

include_recipe "java::default"