# chef-server11

This cookbook configures a system to be a Chef Server

# Overview

Install the Chef Development Kit, available via http://downloads.getchef.com

On Mac OS X and Linux, configure the PATH and GEM environment variables with:

    $ eval "$(chef shell-init bash)"

All cookbook-related development activities are Rake tasks:

    $ rake -T
    rake foodcritic                    # Run Foodcritic style checks
    rake kitchen:all                   # Run all test instances
    rake kitchen:standalone-centos65   # Run standalone-centos65 test instance
    rake kitchen:standalone-ubuntu1404 # Run standalone-ubuntu1404 test instance
    rake kitchen:standalone:converge   # Converge standalone cluster
    rake kitchen:standalone:create     # Create standalone cluster
    rake kitchen:standalone:destroy    # Destroy standalone cluster
    rake kitchen:standalone:login      # Login to chef server
    rake kitchen:standalone:setup      # Setup chef server
    rake kitchen:standalone:verify     # Verify chef server
    rake rubocop                       # Run RuboCop style checks
    rake rubocop:auto_correct          # Auto-correct RuboCop offenses
    rake spec                          # Run RSpec examples

To spin up your very own Chef Server cluster:

    $ rake kitchen:standalone:converge

Access web management UI via the username password `vagrant` / `vagrant`:

   $ https://192.168.33.40

IP address is configurable with the `CHEF_SERVER_IP` environment variable.
