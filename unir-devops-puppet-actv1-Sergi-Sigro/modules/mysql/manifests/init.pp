class mysql{
  $packages = ['mysql-server', 'libapache2-mod-php', 'php-mysql']
  package { $packages:
    ensure => installed
  }

  service{'mysql':
    name => 'mysql',
    ensure => true,
    enable => true,
    require => Package[$packages],
    restart => '/usr/bin/service mysql reload'
  }

  exec {'set-pass':
    unless => "/usr/bin/mysqladmin -u ${username} -p ${password} status",
    command => "/usr/bin/mysqladmin -u ${username} password ${password}",
    require => Service['mysql']
  }

  file {'mv-file':
    path => "${document_root}/create-db.sql",
    ensure => present,
    content => template('mysql/create-db.sql.erb'),
    require => Exec['set-pass']
  }

  notify{'Mysql-installed':
    message => "MySQL installed!",
  }


}
