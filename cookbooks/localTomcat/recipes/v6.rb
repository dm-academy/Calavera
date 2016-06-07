# local Tomcat recipe for v8 
# see https://github.com/chef-cookbooks/tomcat


tomcat_install 'ROOT' do
  version '8.0.35'
  install_path '/var/lib/tomcat8/'
end


tomcat_service 'ROOT' do
  install_path '/var/lib/tomcat8/'
  action [:start, :enable]
end