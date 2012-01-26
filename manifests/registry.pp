class glance::registry(
  $log_verbose = 'false',
  $log_debug = 'false',
  $bind_host = '0.0.0.0',
  $bind_port = '9191',
  $log_file = '/var/log/glance/registry.log',
  $sql_connection = 'sqlite:///var/lib/glance/glance.sqlite',
  $sql_idle_timeout = '3600',
  $paste_deploy_flavor = 'default',
  $service_protocol = 'http',
  $service_host = '127.0.0.1',
  $service_port = '5000',
  $auth_host = '127.0.0.1',
  $auth_port = '35357',
  $auth_protocol = 'http',
  $auth_uri = 'http://127.0.0.1:5000/',
  $admin_token = '999888777666'
) inherits glance {
  file { '/etc/glance/glance-registry.conf':
    ensure  => present,
    owner   => 'glance',
    group   => 'root',
    mode    => '0640',
    content => template('glance/glance-registry.conf.erb'),
    notify  => Service['glance-registry'],
    require => Class['glance']
  }

  file { '/etc/glance/glance-registry-paste.ini':
    ensure  => present,
    owner   => 'glance',
    group   => 'root',
    mode    => '0640',
    content => template('glance/glance-registry-paste.ini.erb'),
    notify  => Service['glance-registry'],
    require => Class['glance']
  }

  service { 'glance-registry':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File['/etc/glance/glance-registry.conf'],
    require    => Class['glance']
  }

}
