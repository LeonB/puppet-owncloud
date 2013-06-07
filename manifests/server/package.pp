class owncloud::server::package {

  # package  { $owncloud::server::packages:
  # ensure => $owncloud::server::ensure
  # }

  # git::repo { 'owncloud':
    # git_tag => 'v5.0.4',
    # path  => $owncloud::server::path,
    # source  => 'git://github.com/owncloud/core.git',
    # owner   => $owncloud::server::user,
    # group   => $owncloud::server::user,
    # mode  => 0644,
  # }

  # apt::source { 'owncloud':
  # ensure      => $owncloud::server::ensure,
  # location    => 'http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_12.10/',
  # release     => '/',
  # repos     => '',
  # key     => '977C43A8BA684223',
  # include_src => false,
  # }
}
