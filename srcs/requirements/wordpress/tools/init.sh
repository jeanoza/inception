wget https://wordpress.org/latest.tar.gz && tar -xvf latest.tar.gz
mkdir -p /var/www/html && mv /wordpress/* /var/www/html
chown -R www-data:www-data /var/www/html

rm -r latest.tar.gz wordpress
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# #modify wp config

#start php7.3-fpm
service php7.3-fpm start