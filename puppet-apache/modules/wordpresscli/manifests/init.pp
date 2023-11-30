class wordpresscli{
  file {'set-commands':
    path => "/user/local/bin/wp",
    ensure => present,
    source => 'puppet:///modules/wordpresscli/wp-cli.phar',
    require => Exec['move-WordPress'],
    mode => "u+x"
  }

  exec{'config-wordpress':
    command => "/usr/local/bin/wp core install --locale=es_SV --title='Mi primera actividad UNIR' --admin=${wp_admin} --admin_password=${password} --admin_email=sergi.sigro@gmail.com --allow-root --path='${base_site}'",
    require => File['set-commands'],
    notify  => Service['apache2'] 
  }

}
