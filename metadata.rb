name 'windows_defender'
maintainer 'Jordan Craig'
maintainer_email 'jordan@jwac.me'
license 'Apache-2.0'
description 'Installs/Configures Windows Defender'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
supports 'windows'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/jordancraig/windows-defender/issues'
source_url 'https://github.com/jordancraig/windows-defender'
