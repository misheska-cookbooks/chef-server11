#
# Cookbook Name:: chef-server11
# Recipe:: default
#

# include helper methods
::Chef::Recipe.send(:include, S3::Helper)

include_recipe 'chef-server11::standalone_server'
