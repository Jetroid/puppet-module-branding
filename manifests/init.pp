# == Class: branding
#
# Copies and sets branding (backgrounds, etc) on agent system.
#
class branding(
  $ensure                  = $branding::params::ensure,
  $desktop_filepath_source = $branding::params::desktop_filepath_source,
  $desktop_filepath_dest   = $branding::params::desktop_filepath_dest,
  $login_filepath_source   = $branding::params::login_filepath_source,
  $login_filepath_dest     = $branding::params::login_filepath_dest,

) inherits branding::params {

  validate_re($ensure, '^(present|absent)$',"${ensure} is not allowed for the 'ensure' parameter. Allowed values are 'present' and 'absent'.")
  validate_string($desktop_filepath_source,$desktop_filepath_dest,$login_filepath_source,$login_filepath_dest)

  anchor { 'branding::begin': } ->
  class { '::branding::install': } ->
  anchor { 'branding::end': }

}
