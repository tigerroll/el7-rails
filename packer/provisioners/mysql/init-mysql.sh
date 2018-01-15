#!/bin/bash
#####################################################################
# http://dev.mysql.com/doc/refman/5.0/en/resetting-permissions.html
# resetting-permissions-unix
#
# mysql_secure_installation
# Authorization data configuration.
#####################################################################

# User Password.
ROOT_KEY="root123"
DB_NAME="rails"
ADM_KEY="rails_adm"
APL_KEY="rails_apl"
DMP_KEY="rails_dmp"
INIT_FILE=/tmp/mysql-init

# Execute User Validations.
set -xeu
[ $(/usr/bin/whoami) = 'root' ] || {
    /bin/echo root only
    exit 1 
}

# Starting MySQL daemon.
systemctl start mysqld.service

# Generate Server Parameter.
/bin/cat <<EOF > ${INIT_FILE}
-- Set the root password
UPDATE mysql.user SET Password=PASSWORD('${ROOT_KEY}') WHERE User='root';
FLUSH PRIVILEGES;

-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Disallow remote root login
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost',  '127.0.0.1',  '::1');

-- Remove test database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- CREATE DATABASE for Benzo.
CREATE DATABASE Benzo;

-- CREATE USER for Benzo_adm.
CREATE USER '${ADM_KEY}'@'%' IDENTIFIED BY '${ADM_KEY}';
grant all privileges on *.* to '${ADM_KEY}'@'%';

-- CREATE USER for Benzo_apl.
CREATE USER '${APL_KEY}'@'%' IDENTIFIED BY '${APL_KEY}';
grant select,update,insert,delete on ${DB_NAME}.* to '${APL_KEY}'@'%';

-- CREATE USER for Benzo_dmp.
grant select, lock tables on *.* TO '${DMP_KEY}'@'%' IDENTIFIED BY '${DMP_KEY}';

-- Reload privilege tables
FLUSH PRIVILEGES;
EOF

# Create sql file.
chmod 600 ${INIT_FILE}
mysql -uroot < ${INIT_FILE}
rm -f ${INIT_FILE}

