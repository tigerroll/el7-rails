#!/usr/bin/env bash
#####################################################################
# Title    :virtualbox guest additions install script.
# Overview :Installing the virtualbox guest additions.
#####################################################################
# Global variable definition area.
#####################################################################
# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
