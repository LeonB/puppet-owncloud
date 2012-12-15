# Class: owncloud::server::params
#
# This class defines default parameters used by the main module class phpmyadmin
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to owncloud::server class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class owncloud::server::params {

	### Application related parameters

	$package_name = $::operatingsystem ? {
		default => 'owncloud'
	}

	$enabled = true

}
