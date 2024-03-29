class wordpresscli{
  file {'set-commands':
    path => "/usr/local/bin/wp",
    ensure => present,
    source => 'puppet:///modules/wordpresscli/wp-cli.phar',
    require => Exec['move-WordPress'],
    mode => "u+x"
  }

  exec{'config-wordpress':
      command => "/usr/local/bin/wp core install --url='http://localhost' --title='Actividad Grupal de Sergi, Eduardo y Unai' --admin_user='${wp_admin}' --admin_password='${password}' --admin_email=sergi.sigro@gmail.com --allow-root --path='${base_site}'",
      require => File['set-commands'],
      notify  => Service['apache2'],
  }


}
