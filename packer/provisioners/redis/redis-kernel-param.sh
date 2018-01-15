#!/usr/bin/env bash
#####################################################################
# Title    :Over Commit memory for Redis.
# Overview :this script for turning the physical memory.
#####################################################################
# Global variable definition area.
#####################################################################
typeset SYS_REDIS=/etc/sysctl.d/turn_redis.conf

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# configure kernel parameters at runtime.
echo "vm.overcommit_memory = 2" >> "${SYS_REDIS}"
echo "vm.swappiness = 0" >> "${SYS_REDIS}"

