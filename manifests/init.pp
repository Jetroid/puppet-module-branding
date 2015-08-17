# == Class: branding
#
# Copies and sets branding (backgrounds, etc) on agent system.
#
class branding(
  $ensure                           = $branding::params::ensure,
  $background_filepath_puppet       = $branding::params::background_filepath_puppet,
  $background_filepath_agent        = $branding::params::background_filepath_agent,
  $login_background_filepath_puppet = $branding::params::login_background_filepath_puppet,
  $login_background_filepath_agent  = $branding::params::login_background_filepath_agent,

) inherits branding::params {

  validate_re($ensure, '^(present|absent)$',"${ensure} is not allowed for the 'ensure' parameter. Allowed values are 'present' and 'absent'.")
  validate_string($background_filepath_puppet,$background_filepath_agent,$login_background_filepath_puppet,$login_background_filepath_agent)

  anchor { 'branding::begin': } ->
  class { '::branding::install': } ->
  anchor { 'branding::end': }

}
