class nginx::params {
  if $::osfamily {
    'RedHat': {
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $config_dir   = '/etc/nginx'
      $logs_dir     = '/var/log/nginx'
      $service_user = 'nginx'
    }
    'Debian': {
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $config_dir   = '/etc/nginx'
      $logs_dir     = '/var/log/nginx'
      $service_user = 'www-data'
    }
    'Windows': {
      $package_name ='nginx-service'
      $file_owner   = 'Administrator'
      $file_group   = 'Administrators'
      $config_dir   = 'C:/ProgramData/nginx'
      $logs_dir     = 'C:/ProgramData/log/nginx'
      $service_user = 'nobody'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
}
