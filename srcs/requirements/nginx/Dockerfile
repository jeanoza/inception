FROM debian:buster

RUN apt-get update -y && apt-get -y install nginx openssl vim
RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=Paris/L=Paris/O=Ecole42/CN=kychoi.42.fr" \
	-out /etc/ssl/certs/kychoi.crt \
	-keyout /etc/ssl/private/kychoi.key


COPY ./conf/nginx /etc/nginx/sites-available/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]