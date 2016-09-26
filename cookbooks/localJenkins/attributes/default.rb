
default['jenkins']['master'].tap do |master|
  master['install_method'] = 'war'
  master['source'] = 'http://mirrors.jenkins-ci.org/war-stable/1.651.3/jenkins.war'
end
