#!/usr/bin/env bash

# redis install.
yum -y --enablerepo=remi,remi-test,epel install redis
redis --version

# Firewall settings.(mysqld)
iptables -I INPUT -p tcp -m tcp --dport 6379 -j ACCEPT
service iptables save

# auto start configure.
systemctl enable redis.service
