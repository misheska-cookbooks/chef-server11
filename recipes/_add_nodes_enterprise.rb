validator_pem_path = node['chef_server11']['organization_private_key_path']
url = "https://#{node['chef_server11']['api_fqdn']}/organizations"\
      "/#{node['chef_server11']['organization']}"

node['chef_server11']['nodes'].each do | _node_fqdn, node_ip|
  # copy validator.pem to node
  execute "scp -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    #{node['chef_server11']['organization_private_key_path']} \
    root@#{node_ip}:#{validator_pem_path}"

  # register the node and a client
  execute "ssh -t -t -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    root@#{node_ip} 'chef-client \
    --server #{url} --validation_key #{validator_pem_path}'"

  # remove server from authorized_keys now that node is bootstrapped
  execute "ssh -t -t -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    root@#{node_ip} 'rm /root/.ssh/authorized_keys'"
end
