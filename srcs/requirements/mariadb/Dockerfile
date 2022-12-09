FROM debian:buster

RUN apt-get update && apt-get install -y  mariadb-server  mariadb-client

COPY ./conf/my.cnf /etc/mysql
COPY ./tools/init.sh /tmp

ENTRYPOINT [ "sh", "/tmp/init.sh" ]