class apache {
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }

  Exec["apt-update"] -> Package <| |>

  package { 'apache2':
    ensure => installed,
  }

  # file { '/etc/apache2/sites-enabled/000-default.conf':
  #   ensure => absent,
  #   require => Package['apache2'],
  # }

  # # Configuración del sitio web
  # file { '/etc/apache2/sites-available/wordpress.conf':
  #   ensure  => present,
  #   content => template('apache/wordpress.conf.erb'),
  #   require => File['/etc/apache2/sites-enabled/000-default.conf'],
  # }

  # # Habilitar el sitio web
  # file { '/etc/apache2/sites-enabled/wordpress.conf':
  #   ensure  => link,
  #   target  => '/etc/apache2/sites-available/wordpress.conf',
  #   require => File['/etc/apache2/sites-available/wordpress.conf'],
  # }

  # #Establecer punto de entrada
  # file { "${document_root}/index.html":
  #   ensure  => present,
  #   source => 'puppet:///modules/apache/index.html',
  #   require => File['/etc/apache2/sites-enabled/wordpress.conf'],
  #   notify  => Service['apache2'],
  # }

  # # Reiniciar Apache después de realizar cambios
  # service { 'apache2':
  #   ensure    => running,
  #   enable    => true,
  #   subscribe => File['/etc/apache2/sites-available/wordpress.conf'],
  # }
 
 ##########################################3
  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure => absent,
    require => Package['apache2'],
  }

  file { '/etc/apache2/sites-available/wordpress.conf':
    content => template('apache/wordpress.conf.erb'),
    require => File['/etc/apache2/sites-enabled/000-default.conf'],
  }

  file { "/etc/apache2/sites-enabled/wordpress.conf":
    ensure  => link,
    target  => "/etc/apache2/sites-available/wordpress.conf",
    require => File['/etc/apache2/sites-available/wordpress.conf'],
    notify  => Service['apache2'],
  }

  file { "${document_root}/index.html":
    ensure  => present,
    source => 'puppet:///modules/apache/index.html',
    require => File['/etc/apache2/sites-enabled/wordpress.conf'],
    notify  => Service['apache2'],
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
  }
}

