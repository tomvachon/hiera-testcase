# Master Puppet Config File

import 'nodes',

Exec {
  path => '/usr/bin:/usr/sbin:/bin:/usr/sbin:/usr/local/rvm/bin' }

filebucket { 'main': server => puppet }

# Global Defaults
File {
  backup => 'main',
  owner  => 'root',
  group  => 'root',
  mode   => '0444',
}


Vcsrepo { provider => 'git', }


exec { 'apt-update':
    command => '/usr/bin/apt-get update',
    onlyif  => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 43200 ))'", # lint:ignore:80chars
}

Exec['apt-update'] -> Package <| |>

