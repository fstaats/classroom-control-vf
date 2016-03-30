class nginx {
  $conf_d_dir = '/etc/nginx/conf.d'
  $default_conf = "${conf_d_dir}/default.conf"
  $nginx_dir = '/etc/nginx'
  $nginx_conf = "${nginx_conf_dir}/nginx.conf"
  $www_dir = '/var/www'
  $index_html = "${www_dir}/index.html"
  
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
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  
  file { $default_conf:
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  
  file { $index_html:
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [
      File[$nginx_conf],
      File[$dfault_conf],
    ]
  }

}
