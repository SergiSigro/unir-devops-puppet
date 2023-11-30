class wordpress (
  String $version = '5.9',
  String $install_dir = $document_root,
) {
  include apache
  # include php
  # include mysql

  # Descargar e instalar WordPress
  # archive { 'wordpress':
  #   ensure    => present,
  #   url       => "https://wordpress.org/wordpress-${version}.tar.gz",
  #   target    => "${install_dir}/wordpress",
  #   extract   => true,
  #   extract_path => "${install_dir}",
  #   creates   => "${install_dir}/wordpress/index.php",
  #   require   => [Class['apache'], Class['php'], Class['mysql']],
  # }
}
