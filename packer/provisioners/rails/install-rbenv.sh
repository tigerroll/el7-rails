#!/usr/bin/env bash
#####################################################################
# Title    :Installing Ruby and Rails with rbenv
# Overview :The first step is to install dependencies for Ruby.
#####################################################################
# Global variable definition area.
#####################################################################

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Execute User Validations.
set -xeu
[ $(/usr/bin/whoami) = "root" ] || {
    /bin/echo "root only." 
    exit 1 
}

# calibration rbenv
# rbenv clone.
git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
# ruby-build clone.
git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"

# Install rbenv
rbenv install --list

# Install Ruby
rbenv install 2.3.1
rbenv global 2.3.1
rbenv init -
rbenv rehash 

export PATH="/usr/local/rbenv/shims:$PATH"
ruby -v

# Install bundler
gem install bundler --no-ri --no-rdoc

# Whenever you install a new version of Ruby or a gem, you should run 
# the rehash sub-command. This will make rails executables known to rbenv, 
# which will allow us to run those executables
rbenv rehash 

# Installing Rails
# And now install Rails
gem install rails -v 4.2.6
rbenv rehash
rails -v

#
cat << 'EOF' > /etc/sudoers.d/rbenv
Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/rbenv/bin:/usr/local/rbenv/shims
Defaults    env_keep += "RBENV_ROOT"
EOF

#
cat << 'EOF' >> /etc/profile.d/rbenv
export RBENV_ROOT="/usr/local/rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init --no-rehash -)"
EOF
