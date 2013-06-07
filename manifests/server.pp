class owncloud::server(
  $packages       = params_lookup( 'packages' ),
  $path           = params_lookup( 'path' ),
  $user           = params_lookup( 'user' ),
  $passwordsalt   = params_lookup( 'passwordsalt' ),
  $mysql_database = params_lookup( 'mysql_database' ),
  $mysql_user     = params_lookup( 'mysql_user' ),
  $mysql_password = params_lookup( 'mysql_password' ),
  $mysql_host     = params_lookup( 'mysql_host' ),
  $instanceid     = params_lookup( 'instanceid' ),
  $enabled        = params_lookup( 'enabled' )
  ) inherits owncloud::server::params {

    $ensure = $enabled ? {
      true => present,
      false => absent
    }

  include owncloud::server::package, owncloud::server::config
}
