#!/usr/bin/env bash
#####################################################################
# Title    :mysql client install script.
# Overview :install MySQL Client.
#####################################################################
# Global variable definition area.
#####################################################################
# Generate for product downlad url.
typeset url="http://ftp.iij.ad.jp/pub/db/mysql/Downloads/MySQL-5.6/"

#####################################################################
# MySQL56 client install.
#####################################################################
eval $(
  curl -s $url|\
  grep -E '.*client.*el7.x86_64.rpm'|\
  awk '{print $6}'|\
  awk -F\> '{print $1}'|\
  tail -1
)
yum -y install "${url}${href}"
