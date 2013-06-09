class owncloud::server::config {

  # do user before package
  Users::Account[$owncloud::server::user] -> Class['sickbeard::package']

  $directory_ensure = $owncloud::server::ensure ? {
    present => link,
    default => $owncloud::server::ensure
  }

  users::account { $owncloud::server::user:
    ensure  => $owncloud::server::ensure,
    uid     => 560,
    home    => $owncloud::server::data_dir,
    shell   => '/bin/false',
    comment => 'Owncloud',
  }

  # nginx::vhost { "owncloud.${::fqdn}":
  #   root  => "${owncloud::server::path}/",
  # }

  # nginx::vhost::snippet { 'root':
  #   vhost   => "owncloud.${::fqdn}",
  #   content => template('owncloud/nginx_vhost.erb'),
  #   ensure  => $owncloud::ensure,
  #  }

  nginx::vhost::snippet { 'owncloud':
    ensure  => $owncloud::ensure,
    vhost   => 'default',
    content => template('owncloud/nginx_vhost_subdirectory.erb'),
  }

  mysql::db { $owncloud::server::mysql_database:
    user     => $owncloud::server::mysql_user,
    password => $owncloud::server::mysql_password,
    host     => $owncloud::server::mysql_host,
    grant    => ['all'],
  }

  # make sure data directory is writeble by php-fpm
  file { $owncloud::server::data_dir:
    ensure  => $owncloud::server::ensure,
    owner   => $owncloud::server::user,
    group   => $owncloud::server::user,
    mode    => '0600',
    recurse => true,
    force   => true
  }

  file { '/etc/owncloud/':
    ensure  => $owncloud::server::ensure,
    owner   => $owncloud::server::user,
    group   => $owncloud::server::user,
    mode    => '0600',
    recurse => false,
    force   => true
  }

  file { '/etc/owncloud/config.php':
    ensure  => $owncloud::server::ensure,
    owner   => $owncloud::server::user,
    group   => $owncloud::server::user,
    mode    => '0600',
    recurse => false,
    content => template('owncloud/config.php.erb'),
  }

  file { "${owncloud::server::path}/config/":
    ensure  => $directory_ensure,
    target  => '/etc/owncloud/',
    force   => true,
    require => [Class['owncloud::server::package'], File['/etc/owncloud/config.php']],
  }

  php::fpm::pool { 'owncloud':
    ensure  => $owncloud::server::ensure,
    port    => 9006,
    require => Users::Account[$owncloud::server::user]
  }

  cron { 'owncloud cron':
    command => "/usr/bin/php5 ${owncloud::server::path}/cron.php",
    user    => $owncloud::server::user,
    hour    => '*',
    minute  => '*',
    require => Users::Account[$owncloud::server::user],
  }

}
