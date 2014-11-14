# include helper methods
::Chef::Recipe.send(:include, PackageCloud::Helper)

package_url = node['chef_server11']['opscode-reporting']['url']
package_name = package_name_from_url(package_url)
package_local_path = local_path_from_url(package_url)

remote_file package_local_path do
  source package_url
end

package package_name do
  source package_local_path
  provider case node['platform_family']
           when 'rhel' then Chef::Provider::Package::Rpm
           when 'debian' then Chef::Provider::Package::Dpkg
           end
#  notifies :run, 'execute[reconfigure-chef-server]', :immediately
end

execute 'opscode-reporting-ctl reconfigure'

execute 'private-chef-ctl restart opscode-reporting'
