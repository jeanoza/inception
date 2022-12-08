FROM debian:buster

# install apt-get package to use
RUN apt-get update && apt-get install -y \
	php7.3 \
	php-fpm \
	php-cli \
	wget \
	curl \
	php-mysql \
	php-mbstring \
	php-xml \
	sendmail \
	vim

# install wordpress
RUN wget https://wordpress.org/latest.tar.gz && tar -xvf latest.tar.gz
RUN mkdir -p /var/www/html && mv /wordpress/* /var/www/html
RUN chown -R www-data:www-data /var/www/html

RUN rm -r latest.tar.gz wordpress
RUN mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#modify wp config

#start php7.3-fpm

ENTRYPOINT ["tail", "-f", "/dev/null"]
