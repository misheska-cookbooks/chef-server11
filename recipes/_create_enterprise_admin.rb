gem_package 'knife-opc'

directory '/etc/opscode' do
  recursive true
end

template '/etc/opscode/knife-opc.rb' do
  variables(:api_fqdn => node['chef_server11']['api_fqdn'])
end

admin_username = node['chef_server11']['admin_username']
admin_firstname = node['chef_server11']['admin_firstname']
admin_lastname = node['chef_server11']['admin_lastname']
admin_email = node['chef_server11']['admin_email']
admin_password = node['chef_server11']['admin_password']
admin_private_key_path = node['chef_server11']['admin_private_key_path']

execute 'create enterprise admin' do
  command <<-EOM.gsub(/\s+/, ' ').strip!
    knife opc user create #{admin_username}
      #{admin_firstname}
      #{admin_lastname}
      #{admin_email}
      #{admin_password}
      --filename #{admin_private_key_path}
      --config /etc/opscode/knife-opc.rb
  EOM
  not_if "knife opc user show #{admin_username} --config /etc/opscode/knife-opc.rb"
end
