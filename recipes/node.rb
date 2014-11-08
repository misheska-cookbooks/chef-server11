# include helper methods
::Chef::Recipe.send(:include, DNS::Helper)

include_recipe 'chef-server11::_configure_node_dns'
include_recipe 'chef-server11::_add_server_to_authorized_keys'

directory '/etc/chef' do
  recursive true
end

if node['chef_server11']['type'] == 'enterprise'
  url = "https://#{node['chef_server11']['api_fqdn']}/organizations"\
      "/#{node['chef_server11']['organization']}"

  file '/etc/chef/client.rb' do
    content <<-EOH
    log_level :info
    log_location STDOUT
    chef_server_url "#{url}"
    validation_client_name "#{node['chef_server11']['organization']}-validator"
    EOH
    mode 0644
    not_if { File.exist?('/etc/chef/client.rb') }
  end
else
  url = node['chef_server11']['api_fqdn']

  file '/etc/chef/client.rb' do
    content <<-EOH
    log_level :info
    log_location STDOUT
    chef_server_url "#{url}"
    EOH
    mode 0644
    not_if { File.exist?('/etc/chef/client.rb') }
  end
end
