class owncloud::server::package {

	package  { $owncloud::server::package_name:
		ensure => $owncloud::server::ensure
	}

	# apt::source { 'owncloud':
	# 	ensure      => $owncloud::server::ensure,
	# 	location    => 'http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_12.10/',
	# 	release     => '/',
	# 	repos       => '',
	# 	key         => '977C43A8BA684223',
	# 	include_src => false,
	# }
}
