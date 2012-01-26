class glance::db(
  $dbname,
  $user,
  $password,
  $host,
  $allowed_hosts = undef
) {

  mysql::db { $dbname:
    user         => $user,
    password     => $password,
    host         => $host,
    charset      => 'latin1',
    require      => Class['mysql::server'],
  }

  if $allowed_hosts {
    glance::db::host_access { $allowed_hosts:
      user      => $user,
      password  => $password,
      database  => $dbname,
    }
  }
}
