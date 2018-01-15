#!/usr/bin/env bash
#####################################################################
# Title    :Clean up garbige.
# Overview :Delete unnecessary file cache after the build.
####################################################################
# al variable definition area.
#####################################################################
typeset INTER_FACE=$(\
  ip a |\
  grep -E '^[0-9]:'|\
  awk '{print $2}'|\
  grep -v 'lo'|\
  awk -F: '{print $1}'\
)

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
#remove network mac and interface information
for i in ${INTER_FACE}
do
  typeset NIC=$(ls -1 "/etc/sysconfig/network-scripts/ifcfg-${i}") 
  [[ -e ${NIC} ]] && $( 
    sed -i "/HWADDR/d" "${NIC}"
    sed -i "/^UUID/d" "${NIC}"
  )
done

#remove any ssh keys or persistent routes, dhcp leases
yum -y clean all
#rm -f /etc/ssh/ssh_host_*
#rm -f /etc/udev/rules.d/70-persistent-net.rules
rm -f /var/lib/dhclient/dhclient*
rm -rf /tmp/rubygems-*
