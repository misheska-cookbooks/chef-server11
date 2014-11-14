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
      '&filename=private-chef-11.2.5-1.el6.x86_64.rpm'
    default['chef_server11']['opscode-manage']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=opscode-manage-1.6.2-1.el6.x86_64.rpm'
    default['chef_server11']['opscode-reporting']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=opscode-reporting-1.1.7-1.x86_64.rpm'
    default['chef_server11']['opscode-push-jobs-server']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=opscode-push-jobs-server-1.1.3-1.el6.x86_64.rpm'
    default['chef_server11']['analytics']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=opscode-analytics-1.0.4-1.el6.x86_64.rpm'
  when 'debian'
    default['chef_server11']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=precise'\
      '&filename=private-chef_11.2.5-1_amd64.deb'
    default['chef_server11']['opscode-manage']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=precise'\
      '&filename=opscode-manage_1.6.2-1_amd64.deb'
    default['chef_server11']['opscode-reporting']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=6'\
      '&filename=opscode-reporting-1.1.7-1.x86_64.rpm'
    default['chef_server11']['opscode-push-jobs-server']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=precise'\
      '&filename=opscode-push-jobs-server_1.1.3-1_amd64.deb'
    default['chef_server11']['analytics']['url'] = \
      'https://packagecloud.io/chef/stable/download?distro=precise'\
      '&filename=opscode-analytics_1.0.4-1_amd64.deb'
  end
end

# Features
default['chef_server11']['feature']['opscode-manage'] = true
default['chef_server11']['feature']['opscode-reporting'] = true
default['chef_server11']['feature']['opscode-push-jobs-server'] = true
default['chef_server11']['feature']['analytics'] = true

default['chef_server11']['admin_username'] = 'chefadmin'
default['chef_server11']['admin_firstname'] = 'Chef'
default['chef_server11']['admin_lastname'] = 'Admin'
default['chef_server11']['admin_email'] = 'chef@chefadmin.com'
default['chef_server11']['admin_password'] = 'chefadmin'
default['chef_server11']['admin_private_key_path'] = '/tmp/chefadmin.pem'
default['chef_server11']['organization'] = 'default'
default['chef_server11']['organization_private_key'] = \
   "#{node['chef_server11']['organization']}-validator.pem"
default['chef_server11']['organization_private_key_path'] = \
   File.join('/tmp', node['chef_server11']['organization_private_key'])
