#!/usr/bin/env bash
#####################################################################
# Title    :add repository script.
# Overview :add yum repository and provisoning confing.
#####################################################################
# Global variable definition area.
#####################################################################
url=''                        # Destination URL.
keywd=''                      # Search keyword.
tags=''                       # The target html tag.
regex=''                      # Regular expression.
rpm_name=''                   # rpm package name.
spacewalk=''                  # Spacewalk client.
remi=''                       # Remi's RPM repository.

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Install Spacewalk client - Free & Open Source Systems Management.
url='http://yum.spacewalkproject.org/latest/RHEL/7/x86_64/'
keywd='spacewalk-client-repo'
tags='a'
regex="/${tags}/{s/.*<${tags}.*>\(.*\)<\/${tags}>.*/\1/;p}"
rpm_name=$(curl -sS "${url}" | grep "${keywd}" |sed -n "${regex}")
spacewalk=$(echo -e "${url}${rpm_name}")
yum -y install "${spacewalk}"

# Install REMI - Remi's RPM repository
url='http://rpms.famillecollet.com/enterprise/'
keywd='remi-release-7'
tags='a'
regex="/${tags}/{s/.*<${tags}.*>\(.*\)<\/${tags}>.*/\1/;p}"
rpm_name=$(curl -sS "${url}" | grep "${keywd}" |sed -n "${regex}")
remi=$(echo -e "${url}${rpm_name}")
yum -y install "${remi}"


