# this is run when installing manosXX in the full pipeline, it initializes the remote git connection to cerebroXX


execute 'register server' do
  user "vagrant"
  group "git"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'ssh-keyscan cerebro1 >> ~/.ssh/known_hosts'   # prevents interactive dialog
end

execute 'define remote' do   # this really needs a guard. when re-building manos, it errors if cerebro has alredy been built.
  user "vagrant"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git remote add origin ssh://cerebro1/home/hijo.git'   # define master git server. high priority to make idempotent.
end


execute 'push to remote' do
  user "vagrant"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git push origin --mirror'   # erase master - if rebuilding manos, assume this is desired. may want to reconsider.
end

execute 'push to remote' do
  user "vagrant"
  cwd '/home/hijo'
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command 'git push origin master'   # push to master git server
end
