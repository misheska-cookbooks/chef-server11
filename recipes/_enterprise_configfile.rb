directory '/etc/opscode' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/opscode/private-chef.rb' do
  action :create
  owner 'root'
  group 'root'
  mode '0644'
end
