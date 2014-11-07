validator_pem_path = '/etc/chef-server/chef-validator.pem'

node['chef_server11']['nodes'].each do | _node_fqdn, node_ip|
  # copy validator.pem to node
  execute "scp -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    #{validator_pem_path} root@#{node_ip}:/etc/chef/chef-validator.pem"

  # register the node and a client
  execute "ssh -t -t -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    root@#{node_ip} 'chef-client \
    --server https://#{node['chef_server11']['api_fqdn']} \
    --validation_key /etc/chef/chef-validator.pem'"

  # remove server from authorized_keys now that node is bootstrapped
  execute "ssh -t -t -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no \
    root@#{node_ip} 'rm /root/.ssh/authorized_keys'"
end
