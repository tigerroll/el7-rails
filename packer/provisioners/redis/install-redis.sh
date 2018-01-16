#!/usr/bin/env bash

# redis install.
yum -y --enablerepo=remi,remi-test,epel install redis
redis --version

# Firewall settings.(nginx)
type firewall-cmd > /dev/null 2>&1 && (
  firewall-cmd --reload;
  firewall-cmd --zone=public --add-port=6379/tcp --permanent;
  firewall-cmd --reload;
  firewall-cmd --list-all;
)

# auto start configure.
systemctl enable redis.service
