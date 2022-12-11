FROM debian:buster

# to verify public cert and private key
# https://8gwifi.org/PemParserFunctions.jsp
# openssl x509 -text -noout -in /etc/ssl/certs/kychoi.crt
# openssl pkey -in /etc/ssl/private/kychoi.key -text -noout
RUN apt-get update -y && apt-get -y install nginx openssl vim
RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=Paris/L=Paris/O=Ecole42/CN=kychoi.42.fr" \
	-out /etc/ssl/certs/kychoi.crt \
	-keyout /etc/ssl/private/kychoi.key


COPY ./conf/nginx /etc/nginx/sites-available/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]