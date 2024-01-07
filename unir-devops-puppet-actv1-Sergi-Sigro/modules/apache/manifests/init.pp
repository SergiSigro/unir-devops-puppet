class apache {
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }

  Exec["apt-update"] -> Package <| |>

  package { 'apache2':
    ensure => installed,
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure => absent,
    require => Package['apache2'],
  }

  file { 'remove-index':
    path => "${base_site}/index.html",
    ensure => absent,
    require => Package['apache2'],
  }

  service { 'apache2':
    ensure    => running,
    enable    => true,
  }

}

