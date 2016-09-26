# local Tomcat recipe for v8
# see https://github.com/chef-cookbooks/tomcat


tomcat_install 'ROOT' do
  version '8.0.36'
  install_path '/var/lib/tomcat8/'
  exclude_manager true
  exclude_hostmanager true
end


tomcat_service 'ROOT' do
  install_path '/var/lib/tomcat8/'
  action [:start, :enable]
end


["/var/lib/tomcat8/webapps/ROOT/WEB-INF/",
 "/var/lib/tomcat8/webapps/ROOT/WEB-INF/lib"].each do | name |

  directory name  do
    mode 00755
    action :create
    recursive true
  end
end

#open up
directory "/var/lib/tomcat8"  do
  mode 00755
  recursive true
end
