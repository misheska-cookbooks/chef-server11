# include helper methods
::Chef::Recipe.send(:include, S3::Helper)
::Chef::Recipe.send(:include, DNS::Helper)

include_recipe 'chef-server11::_configure_server_dns' \
  if node['chef_server11']['write_hosts']
include_recipe 'chef-server11::_install_server'
include_recipe 'chef-server11::_create_admin'
include_recipe 'chef-server11::_create_ssh_key_for_server'
include_recipe 'chef-server11::_add_nodes'
