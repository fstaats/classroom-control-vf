class nginx {
  $conf_d_dir = '/etc/nginx/conf.d'
  $default_conf = "${conf_d_dir}/default.conf"
  $default_conf_source = "puppet:///modules/${module_name}/default.conf"
  $nginx_dir = '/etc/nginx'
  $nginx_conf = "${nginx_conf_dir}/nginx.conf"
  $nginx_conf_source = "puppet:///modules/${module_name}/nginx.conf"
  $www_dir = '/var/www'
  $index_html = "${www_dir}/index.html"
  $index_html_source = "puppet:///modules/${module_name}/index.html"
  
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  package { 'nginx':
    ensure => present,
  }
  
  file { $www_dir:
    ensure  => 'directory',
  }
  
  file { $nginx_dir:
    ensure  => 'directory',
  }
  
  file { $conf_d_dir:
    ensure  => 'directory',
  }
  
  file { $nginx_conf:
    ensure  => file,
    source  => $nginx_conf_source,
    require => Package['nginx'],
  }
  
  file { $default_conf:
    ensure  => file,
    source  => $default_conf_source,
    require => Package['nginx'],
  }
  
  file { $index_html:
    ensure  => file,
    source  => $index_html_source,
    require => Package['nginx'],
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [
      File[$nginx_conf],
      File[$default_conf],
    ]
  }

}
