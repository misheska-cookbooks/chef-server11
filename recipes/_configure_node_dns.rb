node_fqdn = node['chef_server11']['node_fqdn']
node_hostname = hostname_from_fqdn(node_fqdn)

template '/etc/hosts' do
  source 'hosts.node.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    node_fqdn: node_fqdn,
    node_hostname: node_hostname,
    chef_server_fqdn: node['chef_server11']['backend']['fqdn'],
    chef_server_ipaddress: node['chef_server11']['backend']['ipaddress']
  )
end
