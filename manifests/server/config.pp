class owncloud::server::config {

	user { "owncloud":
		gid     => 'owncloud',
		ensure  => $owncloud::server::ensure,
		home    => '/usr/share/owncloud',
		require => Class['owncloud::server::package'],
	}

	group { "owncloud":
		ensure  => $owncloud::server::ensure,
	}

	# make sure data directory is writeble by php-fpm
	file { '/var/lib/owncloud/data/':
		ensure  => $owncloud::server::ensure,
		owner => owncloud,
		group => owncloud,
		mode => 0600,
		recurse => true
	}

	file { '/etc/owncloud/':
		ensure  => $owncloud::server::ensure,
		owner => owncloud,
		group => owncloud,
		mode => 0600,
		recurse => false
	}

	file { '/etc/owncloud/config.php':
		ensure  => $owncloud::server::ensure,
		owner => owncloud,
		group => owncloud,
		mode => 0600,
		recurse => false
	}

	php::fpm::pool { 'owncloud':
		port   => 9006,
		ensure => $owncloud::server::ensure,
		require => User['owncloud']
	}

}
