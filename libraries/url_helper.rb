module S3
  # Helper methods for parsing S3 URLs
  module Helper
    def local_path_from_url(url)
      package_name = package_name_from_url(url)
      File.join(Chef::Config[:file_cache_path], package_name)
    end

    def package_name_from_url(url)
      ::File.basename(url)
    end
  end
end
