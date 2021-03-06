#!/usr/bin/env rake
require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.rspec_opts = '--color'
  end
rescue LoadError
  warn 'It looks like the Chef DK is not configured. Download the Chef DK'\
       " via\nhttps://downloads.getchef.com/chef-dk. On Linux and Mac OS X"\
       " add to $PATH with:\n"\
       '    eval "$(chef shell-init bash)"'
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.fail_on_error = true
    task.options = %w(--display-cop-names)
  end
rescue LoadError
  warn '>>>>> Rubocop gem not loaded, omitting tasks'
end

begin
  require 'foodcritic/rake_task'
  require 'foodcritic'
  task default: [:foodcritic]
  FoodCritic::Rake::LintTask.new do |task|
    task.options = {
      fail_tags: ['any'],
      tags: ['~FC015']
    }
  end
rescue LoadError
  warn '>>>>> foodcritic gem not loaded, omitting tasks'
end

task default: 'test:quick'
namespace :test do
  desc 'Run all the quick tests.'
  task :quick do
    Rake::Task['rubocop'].invoke
    Rake::Task['foodcritic'].invoke
    Rake::Task['spec'].invoke
  end
end

desc 'Bootstrap with chef-solo'
task :bootstrap do
  sh 'rm -rf cookbooks && berks vendor cookbooks'
  sh 'sudo chef-solo --json-attributes bootstrap/standalone.json'\
     '  --config bootstrap/solo.rb'
end

unless ENV['CI']
  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new

    desc 'Run _all_ the tests. Go get a coffee.'
    task :complete do
      Rake::Task['test:quick'].invoke
      Rake::Task['test:kitchen:all'].invoke
    end
  rescue LoadError
    puts '>>>>> Kitchen gem not loaded, omitting tasks'
  end
end

unless ENV['CI']
  namespace :standalone do
    require 'kitchen'

    @centos_instances = []
    @centos_enterprise_instances = []
    @ubuntu_instances = []
    @ubuntu_enterprise_instances = []
    @config = Kitchen::Config.new
    @centos_names = %w(node1-centos65 node2-centos65 standalone-centos65)
    @centos_enterprise_names = %w(node1-enterprise-centos65
                                  node2-enterprise-centos65
                                  standalone-enterprise-centos65)
    @ubuntu_names = %w(node1-ubuntu1404 node2-ubuntu1404 standalone-ubuntu1404)
    @ubuntu_enterprise_names = %w(node1-enterprise-ubuntu1404
                                  node2-enterprise-ubuntu1404
                                  standalone-enterprise-ubuntu1404)
    @centos_names.each do |name|
      @centos_instances << @config.instances.get(name)
    end
    @centos_enterprise_names.each do |name|
      @centos_enterprise_instances << @config.instances.get(name)
    end
    @ubuntu_names.each do |name|
      @ubuntu_instances << @config.instances.get(name)
    end
    @ubuntu_enterprise_names.each do |name|
      @ubuntu_enterprise_instances << @config.instances.get(name)
    end
    @centos_backend_name = 'standalone-centos65'
    @centos_enterprise_backend_name = 'standalone-enterprise-centos65'
    @ubuntu_backend_name = 'standalone-ubuntu1404'
    @ubuntu_enterprise_backend_name = 'standalone-enterprise-ubuntu1404'

    desc 'login to standalone server'
    task :login, :platform do |_t, args|
      platform = args[:platform] || 'centos'
      case platform
      when 'centos' then config.instances.get(@centos_backend_name).login
      when 'centos-enterprise'
        @config.instances.get(@centos_enterprise_backend_name).login
      when 'ubuntu' then config.instances.get(@ubuntu_backend_name).login
      when 'ubuntu-enterprise'
        @config.instances.get(@ubuntu_enterprise_backend_name).login
      end
    end

    desc 'create standalone cluster'
    task :create, :platform do |_t, args|
      platform = args[:platform] || 'centos'
      case platform
      when 'centos' then @centos_instances.each(&:create)
      when 'centos-enterprise'
        @centos_enterprise_instances.each(&:create)
      when 'ubuntu' then @ubuntu_instances.each(&:create)
      when 'ubuntu-enterprise'
        @ubuntu_enterprise_instances.each(&:create)
      else @centos_instances.each(&:create)
      end
    end

    desc 'destroy standalone cluster'
    task :destroy, :platform do |_t, args|
      platform = args[:platform] || 'centos'
      case platform
      when 'centos' then @centos_instances.each(&:destroy)
      when 'centos-enterprise'
        @centos_enterprise_instances.each(&:destroy)
      when 'ubuntu' then @ubuntu_instances.each(&:destroy)
      when 'ubuntu-enterprise'
        @ubuntu_enterprise_instances.each(&:destroy)
      else @centos_instances.each(&:destroy)
      end
    end

    desc 'converge standalone cluster'
    task :converge, :platform do |_t, args|
      platform = args[:platform] || 'centos'
      case platform
      when 'centos' then @centos_instances.each(&:converge)
      when 'centos-enterprise'
        @centos_enterprise_instances.each(&:converge)
      when 'ubuntu' then @ubuntu_instances.each(&:converge)
      when 'ubuntu-enterprise'
        @ubuntu_enterprise_instances.each(&:converge)
      else @centos_instances.each(&:converge)
      end
    end
  end
end
