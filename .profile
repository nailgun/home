# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# include guard
if [ "z$PROFILE_GUARD" != "z" ]; then
	return
fi
export PROFILE_GUARD="yes"

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# bin path
if [ -d "$HOME/.local/bin" ]; then
	export PATH=$HOME/.local/bin:$PATH
fi

# default text editor
if [ "$DISPLAY" -a -x '/usr/bin/gvim' ]; then
    export EDITOR='/usr/bin/gvim -f'
else
    export EDITOR='/usr/bin/vim'
fi

# less options
export LESS="$LESS -R -x4"

# include non shared profile
test -f "$HOME/.profile_local" && . "$HOME/.profile_local"
