require 'spec_helper'

describe S3::Helper do
  let(:url_helper) { Object.new.extend(S3::Helper) }

  before(:each) do
    @url = 'https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64'\
           '/chef-server-11.1.4-1.el6.x86_64.rpm'
    @rpm_name = 'chef-server-11.1.4-1.el6.x86_64.rpm'
  end

  describe 'local_path_from_url' do
    it 'extracts local path from url' do
      expect(url_helper.local_path_from_url(@url)).to match \
             File.join(Chef::Config[:file_cache_path], @rpm_name)
    end
  end

  describe 'package_name_from_url' do
    it 'extracts package name from url' do
      expect(url_helper.package_name_from_url(@url)).to match @rpm_name
    end
  end
end
