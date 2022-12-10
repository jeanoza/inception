#!/bin/bash
PROTECTION="/var/www/html/wordpress/.protection"
wp --info

if  [ ! -f "$PROTECTION" ]; then
	# Download wordpress core
	wp core download --allow-root
	# Create wp-config.php
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost="mariadb" --path="/var/www/html/wordpress/" --allow-root --skip-check
	# Create admin user
	wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --path="/var/www/html/wordpress/" --allow-root
	# Create normal user
	wp user create $WORDPRESS_DFT_USER $WORDPRESS_DFT_EMAIL --role=author --user_pass=$WORDPRESS_DFT_PASSWORD --allow-root
	touch $PROTECTION
fi
exec php-fpm7.3 --nodaemonize

# see more
# wp core: https://developer.wordpress.org/cli/commands/core/
# wp config: https://developer.wordpress.org/cli/commands/config/create/
# wp users: https://developer.wordpress.org/cli/commands/user/