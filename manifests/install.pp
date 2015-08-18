class branding::install (
  $ensure                  = $branding::ensure,
  $desktop_filepath_source = $branding::desktop_filepath_source,
  $desktop_dirpath_dest    = $branding::desktop_dirpath_dest,
  $login_filepath_source   = $branding::login_filepath_source,
  $login_dirpath_dest      = $branding::login_dirpath_dest,

) {

  $desktop_destination = make_dest_path($desktop_filepath_source, $desktop_dirpath_dest)
  $login_destination = make_dest_path($login_filepath_source, $login_dirpath_dest)

  #The if is annoying by necessary to ensure that when
  #the two backgrounds are to be saved in the same directory
  #that the directory resource is not declared twice.
  if $desktop_dirpath_dest != $login_dirpath_dest {
    file{"${login_dirpath_dest}":
      ensure => directory,
    }

    file{"${desktop_dirpath_dest}":
      ensure => directory,
    }
  }else{
    file{"${desktop_dirpath_dest}":
      ensure => directory,
    }
  }

  # Set the desktop background.
  file{"/usr/share/backgrounds/warty-final-ubuntu.png":
    ensure => $ensure,
    source => "${desktop_filepath_source}",
  }

  # Ensure our background is the only one that can be selected.
  file{"/usr/share/gnome-background-properties/":
    ensure => directory,
    source => "puppet:///modules/branding/emptydir",
  }

  # Set the login background.
  
  file{"${login_destination}":
    ensure => $ensure,
    source => "${login_filepath_source}",
  } ->

  file{'/etc/dconf/db/local.d/branding.keys':
    ensure => $ensure,
    content => template('branding/branding.keys.erb'),
  } ->

  file{'/etc/dconf/db/local.d/locks/branding.locks':
    ensure => $ensure,
    source => 'puppet:///modules/branding/branding.locks',
  }

  require dconf_profile 

  # Do a dconf update to propagate
  exec{'dconf-update':
    command => '/usr/bin/dconf update',
      subscribe => [
        File['/etc/dconf/db/local.d/branding.keys'],
        File['/etc/dconf/db/local.d/locks/branding.locks'],
      ],
    refreshonly => true,
  } 

}
