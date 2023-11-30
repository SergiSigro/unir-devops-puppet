class php {

  package { 'php':
    ensure => installed,
  }

  exec { 'php-extensions':
    command => '/usr/bin/apt install php-cli php-fpm php-imap php-redis php-xml php-zip php-mbstring php-mysql -y',
    require => Package['php']
  }

  notify {'php-installed':
    message => 'PHP Installed...',
    require => Exec['php-extensions']
  }
}
