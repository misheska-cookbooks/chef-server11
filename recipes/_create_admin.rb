admin_username = node['chef_server11']['admin_username']
admin_password = node['chef_server11']['admin_password']
admin_private_key_path = node['chef_server11']['admin_private_key_path']
client_key = '/etc/chef-server/admin.pem'

template '/tmp/knife-admin.rb' do
  variables(
    api_fqdn: node['chef_server11']['api_fqdn'],
    admin_username: admin_username,
    client_key: client_key
  )
end

execute 'create admin' do
  command <<-EOM.gsub(/\s+/, ' ').strip!
    knife user create #{admin_username}
    --admin
    --password #{admin_password}
    --disable-editing
    --file #{admin_private_key_path}
    --config /tmp/knife-admin.rb
  EOM
  not_if "knife user show #{admin_username} --config /tmp/knife-admin.rb"
end
