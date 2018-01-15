#!/usr/bin/env bash
#####################################################################
# Title    :advanced nginx configure.
# Overview :nginx server advanced configure script.
#####################################################################
# Global variable definition area.
#####################################################################

# Configure NGINX Env for nginx.
NGINX_SYSCONFIG="/etc/sysconfig/nginx"
ADD_PARAM='
# additional section
NGINX_LANG=ja_JP.UTF-8
'
# Configure NOFILE_LIMITS for nginx.
NOFILE_LIMITS_DIR="/etc/systemd/system/nginx.service.d"
NOFILE_LIMITS_CONF="limits.conf"
NOFILE_LIMITS_PARAM="\
[Service]
LimitNOFILE=infinity
LimitNPROC=infinity"

# Configure Limits for nginx.
NGINX_LIMITS_CONF="/etc/security/limits.d/nginx.conf"
NGINX_LIMITS_PARAM='
# additional section
nginx       soft    nofile  65536
nginx       hard    nofile  65536'

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Configure NGINX Env for nginx.
echo -e "${ADD_PARAM}" >> "${NGINX_SYSCONFIG}"
cat "${NGINX_SYSCONFIG}"

# Configure NOFILE_LIMITS for nginx.
mkdir -p "${NOFILE_LIMITS_DIR}"
echo -e "${NOFILE_LIMITS_PARAM}" >> "${NOFILE_LIMITS_DIR}/${NOFILE_LIMITS_CONF}"
cat "${NOFILE_LIMITS_DIR}/${NOFILE_LIMITS_CONF}"

# Configure Limits for nginx.
echo -e "${NGINX_LIMITS_PARAM}" >> "${NGINX_LIMITS_DIR}/${NGINX_LIMITS_CONF}"
cat "${NGINX_LIMITS_DIR}/${NGINX_LIMITS_CONF}"
