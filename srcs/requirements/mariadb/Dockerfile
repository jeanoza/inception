FROM debian:buster

# on build(image state)
RUN apt-get update && apt-get install -y  mariadb-server  mariadb-client

# WORKDIR /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql
COPY ./tools/init.sh /tmp

EXPOSE 3307

ENTRYPOINT [ "/tmp/init.sh" ]