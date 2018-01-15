#!/usr/bin/env bash
#####################################################################
# Title    :nginx server install script.
# Overview :install nginx server and provisoning confing.
#####################################################################
# Global variable definition area.
#####################################################################
# Authentication information.typeset uid="3000"
typeset uid="3000"
typeset gid="3000"
typeset userid="nginx"
typeset groups="nginx"
typeset usershell="/sbin/nologin"
typeset comments="nginx daemon user."

# nginx core nginx.conf parameter.
NGINX_PROP[0]="gzip\ \ on;"
NGINX_PROP[1]="tcp_nopush\ \ \ \ \ on;"
NGINX_PROP[2]="keepalive_timeout\ \ "

# nginx nginx.conf configure.
NGINX_CONFIG="/etc/nginx/nginx.conf"

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Add Groups.
groupadd -g "${gid}" "${groups}"

# Add Users.
useradd -u "${uid}" -s "${usershell}" "${userid}" \
        -g "${groups}" -M -c "${comments}"

# nginx server install.
yum -y install nginx httpd-tools

# Reflected basic setting in Nginx.
sed -i -E "s/\#${NGINX_PROP[0]}/${NGINX_PROP[0]}/g" ${NGINX_CONFIG}
sed -i -E "s/\#${NGINX_PROP[1]}/${NGINX_PROP[1]}/g" ${NGINX_CONFIG}
sed -i -E "s/\#${NGINX_PROP[2]}65\;/${NGINX_PROP[2]}120\;/g" ${NGINX_CONFIG}
cat ${NGINX_CONFIG}

# Firewall settings.(nginx)
type firewall-cmd > /dev/null 2>&1 && (
  firewall-cmd --reload;
  firewall-cmd --zone=public --add-port=80/tcp --permanent;
  firewall-cmd --zone=public --add-service=http --permanent;
  firewall-cmd --reload;
  firewall-cmd --list-all;
)

# enable auto start.
sudo systemctl enable nginx.service
