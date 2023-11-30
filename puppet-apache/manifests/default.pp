$username = 'root'
$dbname = 'wordpress'
$dbuser = 'wordpress'
$document_root = '/my-first-blog'
$base_site = '/var/www/html'
$wp_admin = 'wp_admin'
$password = 'admin123'



notify { 'Message Box':
  message => "
+-------------------------------------------------------------------------+
|             Author: Sergi Sigró Barruz                                  |
|             Activity: Instalación completa de WordPress con Puppet      |
|             Subject: Herramientas de Automatización de Despliegues      |
+-------------------------------------------------------------------------+
"
}

include apache
include php
include mysql
include wordpress
include wordpresscli

$ipv4_address = $facts['networking']['ip']
notify { 'Showing machine Facts':
  message => "\n
Machine with ${::memory['system']['total']} of memory and ${::processorcount} processor/s.
Please check access to http://${ipv4_address}
",
}
