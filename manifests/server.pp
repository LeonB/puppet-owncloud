class owncloud::server(
	$package_name = params_lookup( 'package_name' ),
	$enabled       = params_lookup( 'enabled' )
  ) inherits owncloud::server::params {

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include owncloud::server::package, owncloud::server::config
}
