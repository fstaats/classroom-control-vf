class nginx::params {
  case $::osfamily {
    'RedHat': {
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $config_dir   = '/etc/nginx'
      $logs_dir     = '/var/log/nginx'
      $service_user = 'nginx'
      $www_dir      = '/var/www'
    }
    'Debian': {
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $config_dir   = '/etc/nginx'
      $logs_dir     = '/var/log/nginx'
      $service_user = 'www-data'
      $www_dir      = '/var/www'
    }
    'Windows': {
      $package_name ='nginx-service'
      $file_owner   = 'Administrator'
      $file_group   = 'Administrators'
      $config_dir   = 'C:/ProgramData/nginx'
      $logs_dir     = 'C:/ProgramData/log/nginx'
      $service_user = 'nobody'
      $www_dir      = 'C:/ProgramData/nginx/html'
    }
  }
}
