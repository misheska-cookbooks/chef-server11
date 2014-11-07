default['chef_server11']['type'] = 'open_source'

case node['chef_server11']['type']
when 'open_source'
  case node['platform_family']
  when 'rhel'
    default['chef_server11']['url'] = \
      'https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64'\
      '/chef-server-11.1.6-1.el6.x86_64.rpm'
  when 'debian'
    default['chef_server11']['url'] = \
      'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64'\
      '/chef-server_11.1.6-1_amd64.deb'
  end
when 'enterprise'
  case node['platform_family']
  when 'rhel'
    default['chef_server11']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=private-chef-11.2.3-1.el6.x86_64.rpm'
  when 'debian'
    default['chef_server11']['open_source']['url']['ubuntu1204'] = \
      'https://packagecloud.io/chef/stable/download?distro=precise'\
      '&filename=private-chef_11.2.3-1_amd64.deb'
  end
end

default['chef_server11']['admin_username'] = 'chefadmin'
default['chef_server11']['admin_password'] = 'chefadmin'
default['chef_server11']['admin_private_key_path'] = '/tmp/chefadmin.pem'
