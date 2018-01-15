#!/usr/bin/env bash
#####################################################################
# Title    :Enabling for port scan deny..
# Overview :This is a DOS attack countermeasure.
#           Activate if there are more than 4 SYN connections 
#           per second.
#####################################################################
# Global variable definition area.
#####################################################################

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Firewall settings.
type firewall-cmd > /dev/null 2>&1 && (
  firewall-cmd --reload;
  firewall-cmd --permanent --direct --add-chain ipv4 filter port-scan;
  firewall-cmd --permanent --direct --add-rule ipv4 filter \
    INPUT 400 -i eno16777736 -p tcp \
    --tcp-flags SYN,ACK,FIN,RST SYN -j port-scan;
  firewall-cmd --permanent --direct --add-rule ipv4 filter \
    port-scan 450 -m limit --limit 1/s --limit-burst 4 -j RETURN;
  firewall-cmd --permanent --direct --add-rule ipv4 filter \
    port-scan 451 -j LOG --log-prefix "IPTABLES PORT-SCAN:";
  firewall-cmd --permanent --direct --add-rule ipv4 filter \
    port-scan 452 -j DROP;
  firewall-cmd --reload;
  firewall-cmd --list-all;
)
