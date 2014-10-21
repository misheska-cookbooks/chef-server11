require 'spec_helper'

if os[:family] == 'redhat'
  if Specinfra::Runner.run_command('rpm -q chef-server').success?
    ctl_command = 'chef-server-ctl test'
  else
    ctl_command = 'private-chef-ctl test'
  end
end

describe 'chef-server11' do
  it 'passes pedant tests' do
    expect(command(ctl_command).exit_status).to eq 0
  end
end
