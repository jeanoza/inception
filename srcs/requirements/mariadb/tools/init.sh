#!/bin/bash
service mysql start;

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE" | mysql -u root
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'" | mysql -u root
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE .* TO '$MYSQL_USER'@'%'" | mysql -u root
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'" | mysql -u root
echo "FLUSH PRIVILEGES" | mysql -u root
# echo "FLUSH PRIVILEGES" | mysql -u root -p $MYSQL_ROOT_PASSWORD

service mysql stop

# exec mysqld_safe
exec mysqld -u root
# exec mysqld -u root -p $MYSQL_ROOT_PASSWORD