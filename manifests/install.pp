class branding::install (
  $ensure                           = $branding::ensure,
  $background_filepath_puppet       = $branding::background_filepath_puppet,
  $background_filepath_agent        = $branding::background_filepath_agent,
  $login_background_filepath_puppet = $branding::login_background_filepath_puppet,
  $login_background_filepath_agent  = $branding::login_background_filepath_agent,

) {

  # Set the desktop background.
  file{"${background_filepath_agent}":
    ensure => $ensure,
    source => "${background_filepath_puppet}",
  } -> 
  
  file{'/etc/dconf/db/local.d/branding.keys':
    ensure => present,
    content => template('branding/branding.keys.erb'),
  } ->

  file{'/etc/dconf/db/local.d/locks/branding.locks':
    ensure => present,
    source => 'puppet:///modules/branding/branding.locks',
  }

  # Set the login background.
  file{"{$login_background_filepath_agent}":
    ensure => $ensure,
    source => "${login_background_filepath_puppet}",
  }

}
