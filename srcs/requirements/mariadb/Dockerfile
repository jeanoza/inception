FROM debian:buster

# on build(image state)
RUN apt-get update && apt-get install -y  mariadb-server  mariadb-client

# WORKDIR /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql
COPY ./tools/init.sh /tmp

# TODO: i use 3307 because my mac use already 3306 => 3306 in evaluation at 42
EXPOSE 3307

ENTRYPOINT [ "/tmp/init.sh" ]