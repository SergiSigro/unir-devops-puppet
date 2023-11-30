class wordpress {
  $wordpress_version = '6.2'
  $wordpress_tar = "wordpress-${wordpress_version}.tar.gz"
  $wordpress_folder = "wordpress"

  exec { 'get-wordpress':
    command => "/usr/bin/wget https://wordpress.org/${wordpress_tar}",
    cwd     => $document_root,
    require => Service['mysql']
  }

  exec { "extract-wordpress":
    command => "/usr/bin/tar -xvzf ${document_root}/${wordpress_tar} -C ${document_root}",
    cwd     => $document_root,
    require => Exec['get-wordpress']
  }

  file { 'config-wordpress':
    path    => "${document_root}/${wordpress_folder}/wp-config.php",
    ensure  => present,
    content => template('wordpress/wp-config.php.erb'),
    mode    => "600",
    require => Exec["extract-wordpress"]
  }

  exec { "grant-access":
    command => "/usr/bin/chmod -R 775 ${document_root}/${wordpress_folder}",
    require => File["config-wordpress"]
  }

  exec { "move-WordPress":
    command => "/usr/bin/mv ${document_root}/${wordpress_folder}/* ${base_site}",
    require => Exec["grant-access"]
  }

  notify {'Wordpress-Installed':
    message => "Module WordPress installed...",
    require => Exec['move-WordPress']
  }
}
