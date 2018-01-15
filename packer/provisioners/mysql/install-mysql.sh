#!/usr/bin/env bash

# repository settings.
yum -y install \
http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum-config-manager --disable mysql55-community
yum-config-manager --disable mysql57-community
yum-config-manager --enable mysql56-community

# mysql install.
yum -y erase mysql-libs
yum -y install mysql mysql-devel mysql-server mysql-utilities 
yum -y install perl-DBI
yum -y install cronie cronie-anacron crontabs sendmail sysstat
mysql --version

# mysql configure.
MYSQL_CONF="/etc/my.cnf"
PARAM_VALUE="\
#\n\
# Customized parameter(s)\n\
#\n\
\n\
# Network\n\
skip-name-resolve\n\
\n\
# Character-set\n\
character-set-server=utf8\n\
collation-server=utf8_general_ci\n\
skip-character-set-client-handshake\n\
\n\
# InnoDB\n\
innodb=FORCE\n\
innodb_buffer_pool_size=1214M\n\
innodb_log_file_size=64M\n\
innodb_file_per_table\n\
\n\
# Slow Query Log\n\
slow_query_log=ON\n\
long_query_time=1\n\
log-queries-not-using-indexes\n\
slow_query_log_file=/var/log/mysql-slow.log\n\
\n\
## Semisynchronous Replication(Master)\n\
#server-id=1\n\
#log-bin=mysql-bin\n\
#plugin-load=rpl_semi_sync_master=semisync_master.so\n\
#rpl_semi_sync_master_enabled=1\n\
#rpl_semi_sync_master_timeout=5000\n\
#\n\
## Semisynchronous Replication(Slave)\n\
#server-id=2\n\
#plugin-load=rpl_semi_sync_slave=semisync_slave.so\n\
#rpl_semi_sync_slave_enabled=1\n"

# Applying MySQL Settings.
sed -i -E "/^\[mysqld\_safe\]/ i ${PARAM_VALUE}" ${MYSQL_CONF}

# Firewall settings.(mysqld)
iptables -I INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
service iptables save

# auto start configure.
systemctl enable mysqld.service
