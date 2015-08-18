class branding::install (
  $ensure                  = $branding::ensure,
  $desktop_filepath_source = $branding::desktop_filepath_source,
  $desktop_dirpath_dest    = $branding::desktop_dirpath_dest,
  $login_filepath_source   = $branding::login_filepath_source,
  $login_dirpath_dest      = $branding::login_dirpath_dest,

) {

  $desktop_destination = make_dest_path($desktop_filepath_source, $desktop_dirpath_dest)
  $login_destination = make_dest_path($login_filepath_source, $login_dirpath_dest)

  require Class['dconf_profile']
  
  # Set the desktop background.
  file{"${desktop_destination}":
    ensure => $ensure,
    source => "${desktop_filepath_source}",
  } -> 
  
  file{'/etc/dconf/db/local.d/branding.keys':
    ensure => $ensure,
    content => template('branding/branding.keys.erb'),
  } ->

  file{'/etc/dconf/db/local.d/locks/branding.locks':
    ensure => $ensure,
    source => 'puppet:///modules/branding/branding.locks',
  }

  # Set the login background.
  file{"${login_destination}":
    ensure => $ensure,
    source => "${login_filepath_source}",
  }

}
