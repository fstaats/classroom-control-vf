class nginx(
  $root = '/var/www'
) inherits nginx::params {
  $package_name = $nginx::params::package_name
  $file_owner   = $nginx::params::file_owner
  $file_group   = $nginx::params::file_group
  $config_dir   = $nginx::params::config_dir
  $logs_dir     = $nginx::params::logs_dir
  $service_user = $nginx::params::service_user
  $www_dir      = $nginx::params::www_dir
  
  $conf_d_dir = '/etc/nginx/conf.d'
  $default_conf = "${conf_d_dir}/default.conf"
  $default_conf_template = "${module_name}/default.conf.erb"
  $nginx_dir = '/etc/nginx'
  $nginx_conf = "${nginx_dir}/nginx.conf"
  $nginx_conf_template = "${module_name}/nginx.conf.erb"
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
    content => template($nginx_conf_template),
  }
  
  file { $default_conf:
    ensure  => file,
    content => template($default_conf_template),
  }
  
  file { $index_html:
    ensure  => file,
    source  => $index_html_source,
  }
}
