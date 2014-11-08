# include helper methods
::Chef::Recipe.send(:include, DNS::Helper)

include_recipe 'chef-server11::_configure_server_dns' \
  if node['chef_server11']['write_hosts']
case node['chef_server11']['type']
  when 'open_source'
    include_recipe 'chef-server11::_install_server'
    include_recipe 'chef-server11::_create_admin'
    include_recipe 'chef-server11::_create_ssh_key_for_server'
    include_recipe 'chef-server11::_add_nodes'
  when 'enterprise'
    include_recipe 'chef-server11::_install_enterprise'
    include_recipe 'chef-server11::_create_enterprise_admin'
    include_recipe 'chef-server11::_create_org'
    include_recipe 'chef-server11::_create_ssh_key_for_server'
    include_recipe 'chef-server11::_add_nodes_enterprise'
end
