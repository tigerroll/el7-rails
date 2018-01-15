#!/usr/bin/env bash
#####################################################################
# Title    :Turning of tcp(ipv4).
# Overview :this script for turning tcp(ipv4).
#####################################################################
# Global variable definition area.
#####################################################################
typeset SYSTCP=/etc/sysctl.d/turn_tcp-ipv4.conf

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# configure kernel parameters at runtime.
echo "net.ipv4.tcp_tw_reuse=1" >> "${SYSTCP}"
echo "net.ipv4.ip_dynaddr=1" >> "${SYSTCP}"
echo "net.ipv4.tcp_rfc1337=1" >> "${SYSTCP}"
echo "net.ipv4.tcp_fin_timeout=10" >> "${SYSTCP}"
echo "net.ipv4.tcp_keepalive_probes=5" >> "${SYSTCP}"
echo "net.ipv4.tcp_slow_start_after_idle=0" >> "${SYSTCP}"
