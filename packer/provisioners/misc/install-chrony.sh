#!/usr/bin/env bash
#####################################################################
# Title    :chrony install script.
# Overview :install chrony ntp service.
#####################################################################
# Global variable definition area.
#####################################################################
CHRONY='/etc/chrony.conf'

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Disable and uninstall ntpd.
systemctl disable ntpd.service
systemctl stop ntpd.service
yum erase -y ntpd

# Enable and Installation of chronyd.
yum install -y chrony
systemctl enable chronyd.service

# Configuration file update.
cat << 'EOF' > ${CHRONY}
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 10.19.32.1 iburst

# Ignore stratum in source selection.
stratumweight 0

# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift

# Enable kernel RTC synchronization.
rtcsync

# In first three updates step the system clock instead of slew
# if the adjustment is larger than 10 seconds.
makestep 10 3

# Listen for commands only on localhost.
port 0
bindcmdaddress 127.0.0.1
bindcmdaddress ::1

keyfile /etc/chrony.keys

# Specify the key used as password for chronyc.
commandkey 1

# Generate command key if missing.
generatecommandkey

# Disable logging of client accesses.
noclientlog

# Send a message to syslog if a clock adjustment is larger than 0.5 seconds.
logchange 0.5

logdir /var/log/chrony

# leap second configureation.
leapsecmode slew
maxslewrate 1000
smoothtime 400 0.001 leaponly
EOF

# Starting chronyd service.
systemctl start chronyd.service

# Forced time synchronization. 
chronyc -a makestep
