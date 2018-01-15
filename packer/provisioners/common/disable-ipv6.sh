#!/usr/bin/env bash
#####################################################################
# Title    :Disable ipv6.
# Overview :this script to disable the ip v6.
#####################################################################
# Global variable definition area.
#####################################################################
typeset NETWKV6=/etc/sysconfig/network
typeset SYSIPV6=/etc/sysctl.d/disable-ipv6.conf
typeset MODIPV6=/etc/modprobe.d/disable-ipv6.conf
typeset NETCONF=/etc/netconfig
typeset HOSTSV6=/etc/hosts

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# configure kernel parameters at runtime.
echo "net.ipv6.conf.all.disable_ipv6=1" >> "${SYSIPV6}"
echo "net.ipv6.conf.default.disable_ipv6=1" >> "${SYSIPV6}"

# configure kernel parameters at runtime.
echo "options ipv6 disable=1" >> "${MODIPV6}"

# configure network parameters.
[[ -f "${NETWKV6}" ]] && {
  echo 'NETWORKING_IPV6=no' >> ${NETWKV6}
  echo 'IPV6INIT=no' >> ${NETWKV6}
  echo 'IPV6_AUTOCONF=no' >> ${NETWKV6}
}

# configure Network Configuration.
[[ -f "${NETCONF}" ]] && {
  sed -i -e 's/^udp6/#udp6/g' "${NETCONF}"
  sed -i -e 's/^tcp6/#tcp6/g' "${NETCONF}"
}

# configure hosts Configuration.
[[ -f "${HOSTSV6}" ]] && {
  sed -i -E 's/::1/#::1/g' /etc/hosts
}
