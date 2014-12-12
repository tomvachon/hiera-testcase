require 'spec_helper'

describe 'base_packages' do
  code_names = ['trusty', 'precise', 'sqeeze']
  code_name_specific_packages = {
    'trusty' => ['libmagick++4', 'libjson-ruby'],
    'precise' => ['libmagick++5'],
    'sqeeze' => []
  }
  common_packages = [
    'emacs',
    'git',
    'imagemagick',
    'libmagick++-dev',
    'libmagickcore-dev',
    'libmagickwand-dev',
    'libcache-memcached-perl',
    'libsys-hostname-long-perl',
    'mailutils',
    'libnet-amazon-ec2-perl',
    'sharutils',
    'sysstat',
    'ntpdate',
    'libgeos-3.2.2',
    'libgeos-dev',
    'geoip-bin',
    'zsh',
    's3cmd'
  ]
  code_names.each do |distro|
    context "lsbdistcodename-#{distro}" do
      let(:facts) { { lsbdistcodename: distro, operatingsystem: 'ubuntu' } }
      Puppet::Util::Log.level = :debug
      Puppet::Util::Log.newdestination(:console)
      common_packages.each do |package|
        it "should have package #{package}" do
          should contain_package(package)
            .with_ensure('present')
        end
      end
      code_name_specific_packages[distro].each do |package|
        it "should have distro specific package #{package}" do
          should contain_package(package)
            .with_ensure('present')
        end
      end
    end
  end
end
