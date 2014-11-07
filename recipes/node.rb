# include helper methods
::Chef::Recipe.send(:include, DNS::Helper)

include_recipe 'chef-server11::_configure_node_dns'
include_recipe 'chef-server11::_add_server_to_authorized_keys'

directory '/etc/chef' do
  recursive true
end

file '/etc/chef/client.rb' do
  content <<-EOH
  log_level :info
  log_location STDOUT
  chef_server_url "#{node['chef_server11']['api_fqdn']}"
  EOH
  mode 0644
  not_if { File.exist?('/etc/chef/client.rb') }
end
