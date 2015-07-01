#override['java']['install_flavor'] = 'openjdk'

override['java']['install_flavor'] = 'oracle'
override['java']['jdk_version'] = '7'
override['java']['oracle']["accept_oracle_download_terms"] = true

default['java']['ant_version'] = 'apache-ant-1.9.5'
default['java']['ant_mirror'] = 'http://mirror.nexcess.net/apache/ant/binaries'