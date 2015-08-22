class branding::install (
  $ensure                  = $branding::ensure,
  $desktop_filepath_source = $branding::desktop_filepath_source,
  $desktop_dirpath_dest    = $branding::desktop_dirpath_dest,
  $login_filepath_source   = $branding::login_filepath_source,
  $login_dirpath_dest      = $branding::login_dirpath_dest,
  $blank_screen            = $branding::blank_screen,
  $draw_user_backgrounds   = $branding::draw_user_backgrounds,
  $draw_grid               = $branding::draw_grid,

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
  file{"${desktop_destination}":
    ensure => $ensure,
    source => "${desktop_filepath_source}",
  } ->

  # Set the login background.
  file{"${login_destination}":
    ensure => $ensure,
    source => "${login_filepath_source}",
  } ->

  # Add these to dconf.
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
  exec{'dconf-update-branding':
    command => '/usr/bin/dconf update',
      subscribe => [
        File['/etc/dconf/db/local.d/branding.keys'],
        File['/etc/dconf/db/local.d/locks/branding.locks'],
      ],
    refreshonly => true,
  } 

}
