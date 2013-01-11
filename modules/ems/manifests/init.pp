class ems inherits ems::params{

  package { 'ems':
    provider => rpm,
    ensure   => present,
    source   => "${ems_rpm_source}",
  }

  exec { 'chown_ems_home':
    command => "chown -R ${ems_owner}:${ems_group} ${ems_home_folder}",
    path    => '/bin',
    require => Package['ems'],
  }
	
# This did not work	
#  file { 'ems_home' :
#    path    => "${ems_home_folder}",
#    owner   => "${ems_owner}",
#    group   => "${ems_group}",
#    recurse => true,
#    require => Package['ems'],
#  }

  exec { 'chown_ems_data':
    command  => "chown -R ${ems_owner}:${ems_group} ${ems_data_folder}",
    path     => '/bin',
    require  => Package['ems'],
  }

# This did not work	
#  file { 'ems_data' :
#    path    => "${ems_data_folder}",
#    owner   => "vagrant",
#    group   => "vagrant",
#    recurse => true,
#    require => Package['ems'],
#  }

}