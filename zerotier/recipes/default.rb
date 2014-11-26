#
# Cookbook Name:: zerotier
# Recipe:: default
#
#
remote_file "#{Chef::Config[:file_cache_path]}/ZeroTierOneInstaller-linux-x64" do
  source "https://www.zerotier.com/dist/ZeroTierOneInstaller-linux-x64"
  backup false
  action :create_if_missing
  checksum "013e67966b52ccd791cfb8ad5502fa5e3780869ade4fbdeb640c8e4ef3089fb5"
  mode "755"
end

bash "install zerotier" do
  user "root"
  code "#{Chef::Config[:file_cache_path]}/ZeroTierOneInstaller-linux-x64"
end

bash "join network #{node.zerotier.network_id}" do
  user "root"
  code "zerotier-cli join #{node.zerotier.network_id}"
  not_if "/sbin/ifconfig | grep zt0"
end
