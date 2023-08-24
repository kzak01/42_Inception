#!/bin/sh

# Check if the /run/mysqld directory exists, and create it if not
if [ ! -d "/run/mysqld" ]
then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# Check if the /var/lib/mysql/mysql directory exists, and create it if not
if [ ! -d "/var/lib/mysql/mysql" ]
then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	# Create a temporary file to execute SQL commands
	tmp=`mktemp`

	if [ ! -f "$tmp" ]
	then
		return 1
	fi

	# Define SQL commands to set up MariaDB user and database
	cat << EOF > $tmp
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS';
CREATE DATABASE $MARIADB_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASS';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF

	# Bootstrap MariaDB with the defined SQL commands
	/usr/bin/mysqld --user=mysql --bootstrap < $tmp
	rm -f $tmp
fi

# Modify the MariaDB configuration to allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

echo "MariaDB starting"

# Start MariaDB with the modified configuration
exec /usr/bin/mysqld --user=mysql --console
