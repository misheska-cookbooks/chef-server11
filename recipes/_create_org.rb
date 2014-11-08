user = node['chef_server11']['admin_username']
organization = node['chef_server11']['organization']
organization_private_key_path = \
  node['chef_server11']['organization_private_key_path']

execute 'create_chef_org' do
  command <<-EOM.gsub(/\s+/, ' ').strip!
    knife opc org create #{organization}
      'Chef Test Org'
      --association_user #{user}
      --filename #{organization_private_key_path}
      --config /etc/opscode/knife-opc.rb
  EOM
  creates organization_private_key_path
end
