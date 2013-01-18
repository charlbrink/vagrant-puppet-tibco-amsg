node default {
  
  $PROXY_USER = 'PROXY_USER_NAME'         #Change PROXY_USER_NAME to username required for proxy
  $PROXY_PASSWORD = 'PROXY_PASSWORD'      #Change PROXY_PASSWORD to password required for proxy
  $PROXY_PROTOCOL = 'http'                #Change to protocol required for proxy
  $PROXY_HOST = 'PROXY_HOST'              #Change to proxy host name or ip
  $PROXY_PORT = '81'                      #Change to proxy port
  $PROXY_URL = "${PROXY_PROTOCOL}://${PROXY_USER}:${PROXY_PASSWORD}@${PROXY_HOST}:${PROXY_PORT}"
  
#  notify { 'proxy_setting':
#    message => "Using following settings for PROXY: url=${PROXY_URL}",
#  }
  
  file { '/home/vagrant/.bash_profile' :
    path    => '/home/vagrant/.bash_profile',
    content => template('bash_profile.erb'),
  }

  file { '/etc/yum.conf' :
    path    => '/etc/yum.conf',
    content => template('yum.conf.erb'),
  }

  file { '/etc/wgetrc' :
    path    => '/etc/wgetrc',
    content => template('wgetrc.erb'),
  }

  file { '/etc/hosts' :
    path    => '/etc/hosts',
    content => template('hosts.erb'),
  }

  # Install "Desktop" group - mandatory
  $desktop_mandatory_packages = [ 'NetworkManager', 'NetworkManager-gnome', 'alsa-plugins-pulseaudio', 'at-spi',
              'control-center', 'dbus', 'gdm', 'gdm-user-switch-applet', 'gnome-panel', 'gnome-power-manager',
              'gnome-screensaver', 'gnome-session', 'gnome-terminal', 'gvfs-archive', 'gvfs-fuse',
              'gvfs-smb', 'metacity', 'nautilus', 'notification-daemon', 'polkit-gnome', 'xdg-user-dirs-gtk',
              'yelp'  ]
  package { $desktop_mandatory_packages:
    ensure  => present,
    require => File['/etc/yum.conf'],
  }

  # Install "Desktop" group - default
  # Removed 'rhn-setup-gnome' as Centos does not use it          
#  $desktop_default_packages = [ 'control-center-extra', 'eog', 'gdm-plugin-fingerprint', 'gnome-applets',
#             'gnome-media', 'gnome-packagekit', 'gnome-vfs2-smb', 'gok', 'openssh-askpass',
#             'orca', 'pulseaudio-module-gconf', 'pulseaudio-module-x11', 'vino' ]

#  package { $desktop_default_packages:
#    ensure  => present,
#    require => File['/etc/yum.conf'],
#  }

  # Install "Desktop" group - optional
#  $desktop_optional_packages = [ 'sabayon-apply', 'tigervnc-server', 'xguest' ]
#  package { $desktop_optional_packages:
#    ensure  => present,
#    require => File['/etc/yum.conf'],
#  }

  # Install extra convenience packages
  $extra_packages = [ 'subversion', 'gedit', 'man', 'file-roller', 'unzip' ]
  package { $extra_packages:
    ensure  => present,
    require => File['/etc/yum.conf'],
  }

  # Install "Internet Browser" group
  $browser_packages = [ 'firefox', 'nspluginwrapper', 'totem-mozplugin' ]
  package { $browser_packages:
    ensure  => present,
    require => File['/etc/yum.conf'],
  }

  # Download rpm to add EPEL (Extra Packages for Enterprise Linux) repo
#  exec { 'wget-epel':
#    command => "wget --output-document=/tmp/epel-release-6-8.noarch.rpm http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
#    path    => '/usr/bin',
#    creates => "/tmp/epel-release-6-8.noarch.rpm",
#    require => File['/home/vagrant/.bash_profile'],
#  }
  
  # Add EPEL (Extra Packages for Enterprise Linux) repo
#  package { 'epel':
#    provider => rpm,
#    ensure   => present,
#    source   => "/tmp/epel-release-6-8.noarch.rpm",
#    require  => Exec['wget-epel'],
#  }
  
  # Install ems module 
  include ems

  # Install amsg module 
  include amsg

}