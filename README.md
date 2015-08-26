# branding

#### Table of Contents

1. [Overview](#overview)
2. [Parameters](#parameters)
3. [Limitations](#limitations)
4. [Release Notes](#release-notes)

## Overview

This module adds and sets background images for both login and desktop wallpapers, using dconf.

## Parameters

ensure
------

Defines if branding and its relevant files are to be installed or removed.

Accepts: 'present', 'absent'
Default: 'present'

desktop_filepath_source
-----------------------

The source image the the desktop background. Can be either an image local on the machine,
eg: '/usr/share/desktops/warty-final-ubuntu.png',
or it can be a file in a module on the server,
eg: 'puppet:///modules/my_module/filename.jpg' 
(for a picture named filename.jpg inside the files directory in the module my_module)

Accepts: String
Default: '/usr/share/desktops/warty-final-ubuntu.png'

desktop_dirpath_dest
--------------------

The destination for the desktop background to be copied into on the target machine.
The trailing slash is optional.

Accepts: String
Default: '/usr/share/desktops/'

login_filepath_source
-----------------------

The source image the the login background. Can be either an image local on the machine,
eg: '/usr/share/desktops/warty-final-ubuntu.png',
or it can be a file in a module on the server,
eg: 'puppet:///modules/my_module/filename.jpg' 
(for a picture named filename.jpg inside the files directory in the module my_module)

Accepts: String
Default: '/usr/share/desktops/warty-final-ubuntu.png'

desktop_dirpath_dest
--------------------

The destination for the login background to be copied into on the target machine.
The trailing slash is optional.

Accepts: String
Default: '/usr/share/desktops/'

blank_screen
------------

Defines if the machine should turn the screen black after periods of inactivity.
Setting this to true allows the machine to blank it's screen after 6 minutes.

Accepts: Boolean
Default: false

draw_user_backgrounds
---------------------

Defines if the machine should allow the background for the login screen to change 
depending on which user is highlighted.

Accepts: Boolean
Default: false

draw_grid
---------

Defines if the 'dots' present on the unity-greeter should be rendered or not.

Accepts: Boolean
Default: false

## Limitations

Currently only sets the login background when unity-greeter is used as the login greeter.

Tested on Ubuntu 14.04 64bit/32bit.

## Release Notes/Contributors/Etc 

0.1.0 - Initial Release 
