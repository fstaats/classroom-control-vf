class nginx {
  $package_name ='nginx'
  $file_owner   = 'root'
  $file_group   = 'root'
  $config_dir   = '/etc/nginx'
  $logs_dir     = '/var/log/nginx'
  $service_user = 'nginx'
  $www_dir      = '/var/www'
  
  $conf_d_dir = '/etc/nginx/conf.d'
  $default_conf = "${conf_d_dir}/default.conf"
  $default_conf_source = "puppet:///modules/${module_name}/default.conf.erb"
  $nginx_dir = '/etc/nginx'
  $nginx_conf = "${nginx_conf_dir}/nginx.conf"
  $nginx_conf_source = "puppet:///modules/${module_name}/nginx.conf.erb"
  $index_html = "${www_dir}/index.html"
  $index_html_source = "puppet:///modules/${module_name}/index.html"

  
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  package { 'nginx':
    ensure => present,
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
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
    source  => template($nginx_conf_source),
  }
  
  file { $default_conf:
    ensure  => file,
    source  => template($default_conf_source),
  }
  
  file { $index_html:
    ensure  => file,
    source  => $index_html_source,
  }
}
