class amsg inherits amsg::params {

  package { "${compat_libstdc_package}":
    ensure => present,
  }
  
  package { 'amsg':
    provider => rpm,
    ensure   => present,
    source   => "${amsg_rpm_source}",
	require  => Package["${compat_libstdc_package}"],
  }

  exec { 'chown_amx_home':
    command => "chown -R ${amsg_owner}:${amsg_group} ${amsg_home_folder}",
    path    => '/bin',
    require => Package['amsg'],
  }

# This did not work  
#  file { 'amx_home' :
#    path    => "${amsg_home_folder}",
#    owner   => "${amsg_owner}",
#    group   => "${amsg_group}",
#    recurse => true,
#    require => Package['amsg'],
#  }

  exec { 'chown_amx_data':
    command => "chown -R ${amsg_owner}:${amsg_group} ${amsg_data_folder}",
    path    => '/bin',
    require => Package['amsg'],
  }

# This did not work  
#  file { 'amx_data' :
#    path    => "${amsg_data_folder}",
#    owner   => "${amsg_owner}",
#    group   => "${amsg_group}",
#    recurse => true,
#    require => Package['amsg'],
#  }

}