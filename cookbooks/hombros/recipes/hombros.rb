# set up Jenkins server

directory "/var/lib/jenkins/.ssh"  do
  mode 00755
  action :create
  recursive true
end

execute 'duplicate keys' do
  cwd '/home/vagrant/.ssh'
  command 'cp id_rsa* /var/lib/jenkins/.ssh'   
end

execute 'correct Jenkins directory ownership' do
  command 'chown -R jenkins /var/lib/jenkins &&  \
          chgrp -R jenkins /var/lib/jenkins'  
end

# create credential

#jenkins_credentials 'jenkins' do
#  action :delete
#end

  #description 'test pw'
  #password 'test1234'

jenkins_private_key_credentials 'jenkins' do
  id '1ea894fc-d69e-4f2e-ba27-30bf66f774b3'
  description 'SSH key'
  private_key "-----BEGIN RSA PRIVATE KEY-----\n"+ 
"MIIEpgIBAAKCAQEAonaSkhxhTZHWa2uIjbqg9L/WtWyZh4he25AsBnGGKVWxWP07\n"+
"AX5oekShQRg/X1oIoTFOmdfA3rHbSvaadCZT5UKz4gDaF+tw+c6jrMBoW7mEnxLc\n"+
"g+dglp13GygDTJN4w9B9/m5WGzEgaSTo33uI7E+8ssVlrqutiRNSTUwsyOoPrFr2\n"+
"PZ+Z038QjRH7kCr63Okq/OjBhMFJt4nJ4DTutEa1drLRMQjkvILgnUdLD4TvULUe\n"+
"ywfCHlvoMNm5B4hShIGkrwPwhdF/2Jw1nSfJ9q91T+0+/tgj/0KjcLCrGVgHPyJB\n"+
"N1YuHmyyfCaHKDd5trgy0WFWSIn6Ji7mheCVuQIDAQABAoIBAQCJGn2pFpA7EScd\n"+
"sjskOGqbAcZlhwet7DT5IBs3ONjayzmGevYv1YjAHmjjcV4Rzv5XYjAN/pkClqAV\n"+
"DDXebXYBlSAPS17CLuxBtNRF9n5bYh18zUMRgdLuaGbaoRLfrdiNj8a0UFMUUYoj\n"+
"kYWBDFTJ8KSzTYj5NmKVupuLJgzpY91xahhAPaalyLnYc/KQg33S+Q3aUJGi3CmE\n"+
"2sjzWrdQNyLb/bycs+h4BRwNLGZrWAmP6MSclVupq1YVpWTHlxoWOFiuE9zHhkE0\n"+
"YtCKyv3OQAe8VzYVxVP0fg0NeaOKeo5KtFEkO0z0bhRo8aD89zr93o99W4Epx5Il\n"+
"SfHzh1IxAoGBANOeMj6/JMv7a91/hRiIDRc969shYwBS5VHnlO9lWzvpWCseicts\n"+
"nzh8t4Gjcg3k+wdu6Y/K9zEesDcjocyycyBwq1RlqofCo0djGA3hfbzeLF2BIbvM\n"+
"4dqTHFc7af07vugFRHi2/SGD6s/RUHvHm//JbKVw5+0QqaCiU9u+EqkFAoGBAMSJ\n"+
"P3DOuATu0/flrymP1IqC+iRfq4/rkGEjdiqk0zcSf7JFYilA5kWzUwY0iWr9134d\n"+
"w19kcWqW7XipAAQCHk1BepZC6a/Ogu+5pWdPaQF6ALFtpKvHnsS5C9shha4xlxms\n"+
"zboYIpK2Xg4pxzzN+mNdu7C42HkX6pa2PRwFLgglAoGBAMQCUKnb5FpoG+YC+qXZ\n"+
"Rr7TZQYIa6neHnh513LSX+ojXb46wAlDKEtrAZI7cSY7hOTCr+W3arT9pty7zV9L\n"+
"nuVaVueKb6Tl/NTfjWU2CoAJDfDh7fwEbuJExshpyOd9EnvYfS6O1/HWPYWWbETq\n"+
"g60txcuLw9bKS0P1d1UfPit9AoGBAIiFHgBqWAF1NOC6N5aTRnyAxumFW1M5uqz/\n"+
"SRIONHnI69MVxz4IyuwXyNBCpkIf2hTM7+3Pg8ka1hI+srgWEJ5xoYnHKTTqKqID\n"+
"PxYoXzSbXufg1cZNf8f/EnFBM+7wm5lGJBHkuf9XlrYX50IhgpCLh9kWTaiwKFBQ\n"+
"ftp77qHRAoGBAI+5EqKdTdvi4vHkOiwok2B4GIaRGuMfDmh7/tq8Ns8KnWhtocTb\n"+
"JO5QXlxFo+TjRv1m0Xvdvf681WP1VXa1Zt7BYfLQRbnp9kCMiLqN1pYzDknAmEWB\n"+
"FWc/y0KNgKkqV/WHhKBqDE2PdBG3tpEBtQYZ/ag+p5PpmVYyFPD8UYS8\n"+
"-----END RSA PRIVATE KEY-----\n"
#"\n"+
#"-----BEGIN RSA PUBLIC KEY-----\n"+
#"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCidpKSHGFNkdZra4iNuqD0v9a1"+
#"bJmHiF7bkCwGcYYpVbFY/TsBfmh6RKFBGD9fWgihMU6Z18DesdtK9pp0JlPlQrPiA"+
#"NoX63D5zqOswGhbuYSfEtyD52CWnXcbKANMk3jD0H3+blYbMSBpJOjfe4jsT7yyxW"+
#"Wuq62JE1JNTCzI6g+sWvY9n5nTfxCNEfuQKvrc6Sr86MGEwUm3icngNO60RrV2stE"+
#"xCOS8guCdR0sPhO9QtR7LB8IeW+gw2bkHiFKEgaSvA/CF0X/YnDWdJ8n2r3VP7T7+"+
#"2CP/QqNwsKsZWAc/IkE3Vi4ebLJ8JocoN3m2uDLRYVZIifomLuaF4JW5\n"+
#"-----END RSA PUBLIC KEY-----"
end


# create slave
jenkins_ssh_slave 'brazos' do
  description 'Run test suites'
  remote_fs   '/home/jenkins'
  #labels      ['executor', 'freebsd', 'jail']

  # SSH specific attributes
  host        'brazos' # or 'slave.example.org'
  user        'jenkins'
  credentials 'jenkins'
end

#ESSENTIAL - set master to 0 executors


#jenkins_plugin 'git-client' do
#  action :uninstall
#end

jenkins_plugin 'git' do   #install git plugin
  #action :uninstall
  notifies :restart, 'service[jenkins]', :immediately
end

jenkins_plugin 'artifactory' do   #install artifactory plugin
  #action :uninstall
  notifies :restart, 'service[jenkins]', :immediately
end


cookbook_file "hijoInit.xml" do    # downloaded from manually defined job. todo: convert this to erb file
  path "#{Chef::Config[:file_cache_path]}/hijoInit.xml"
  mode 0744
end

xml = File.join(Chef::Config[:file_cache_path], 'hijoInit.xml')

jenkins_job 'hijoInit' do
  config xml
end

#jenkins_command 'safe-restart'

# project name hijoInit



