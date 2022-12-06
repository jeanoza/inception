FROM debian:buster

# on build(image state)
RUN apt-get update && apt-get install -y  nginx openssl

# COPY ./conf/my.cnf /etc/mysql
# COPY ./tools/init.sh /tmp

# EXPOSE 433

# ENTRYPOINT [ "/tmp/init.sh" ]

# to debugger with docker-compose
# ENTRYPOINT ["tail", "-f", "/dev/null"]