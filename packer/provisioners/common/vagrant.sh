#!/usr/bin/env bash
#####################################################################
# Title    :Installing vagrant keys.
# Overview :Install vagrant user public keys.
#####################################################################
# Global variable definition area.
#####################################################################
typeset GitHub="https://raw.github.com/mitchellh/vagrant/master/keys/"
typeset PubKey="vagrant.pub"
typeset SSH_Dir="/home/vagrant/.ssh"
typeset Authorized_keys="${SSH_Dir}/authorized_keys"

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Installing vagrant keys
mkdir -pm 700 ${SSH_Dir}
wget --no-check-certificate "${GitHub}${PubKey}" -O "${Authorized_keys}"
chmod 0600 "${Authorized_keys}"
chown -R vagrant:vagrant "${SSH_Dir}"

# Vagrant specific
date > /etc/vagrant_box_build_time

# Customize the message of the day
echo 'Welcome to your vagrant built virtual machine.' > /etc/motd
