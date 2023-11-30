class wordpress {
  exec { 'get-wordpress':
    command => "/usr/bin/wget https://wordpress.org/wordpress-6.2.tar.gz", 
    cwd => $document_root,
    require => Service['mysql']
  }

  exec { "/usr/bin/tar -xvzf ${document_root}/wordpress-6.2.tar.gz":
    require => Exec['get-wordpress']
  }

  file{ 'config-wordpress':
    path => "${document_root}/wordpress/wp-config.php",
    ensure  => present,
    content => template('wordpress/wp-config.php.erb'), 
    mode => "600",
    require => Exec["/usr/bin/tar -xvzf ${document_root}/wordpress-6.2.tar.gz"]
  }

  exec { "grant-access":
    command => "/usr/bin/chmod -R 775 ${document_root}/wordpress",
    require => File["config-wordpress"]
  }

  exec { "move-WordPress":
    command => "/usr/bin/mv ${document_root}/wordpress/* ${base_site}", 
    require => Exec["grant-access"]
  }

  notify {'Wordpress-Installed':
    message => "Module WordPress installed...",
    require => Exec['move-WordPress']
  }
}
