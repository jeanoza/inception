# Inception

## Resume

### Goal :

- Using Docker, deploy a service which can be used in every OS(linux, window, mac OS(intel/M1), ...etc.

### Stacks

- Docker

- Docker Containers:
    
	- NGINX, TLSv1.2(ou 1.3)

	- WordPress + php-fpm(installed and configured)

	- MariaDB without Nginx

- Volume

	- WordPress Database

	- WordPress Files
	
- Docker-network: bind the containers.

### Subject

1. How to use `Dockerfiles` and `PID 1`

2. Two user in WordPress DB

	- one is `Admin` (username doesn't contains hint of administrator like admin-123 ... etc)

	- other is normal user

3. DO NOT use:


	- Dockerhub images like: Wordpress, nginx... etc
		
		=> Use only `Alpine` or `Debian` image

	- hacky patch(not recommanded)

	- host, --link, links
			
		> `network` must be defined in `docker-compose.yml`

	- `infinity loop` such as while true...


## Program


### Packages

- wordpress container:
	- wordpress(maybe not directly 'apt-get install wordpress' but with curl...?)
	- php-fpm(need php d'abord) => php version...?

- nginx container:
	- nginx
	- openssl

- mariadb container :
	- mariadb-server
	- mariadb-client

### Init Containers

1. Mariadb

	```bash
	docker run --name mariadb -it \
	-v /Users/kyubongchoi/data/db_volume:/var/lib/mysql \
	-v $(pwd)/srcs/requirements/mariadb/conf:/tmp/conf \
	-v $(pwd)/srcs/requirements/mariadb/tools:/tmp/tools \
	--env-file $(pwd)/srcs/.env \
	-p 3307:3307 \
	debian:buster
	```
	* 3306 port is in use in my mac => that's why i put 3307 temporally

	1-1. install packages => `RUN`

	```bash
	# Remove old volume db
	# but not need in Dockerfile, in debian:buster image mysql is not installed
	rm -r /var/lib/mysql/* 2> /dev/null
	# Install packages
	apt-get update && apt-get install -y mariadb-server mariadb-client
	```

	1-2. init mariadb => `CMD` or `ENTRYPOINT` in Dockerfile...?


	```bash
	# Init mariadb
	service mysql start;
	
	# create wordpress db
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE" | mysql -u root;
	# create a user with its pw
	# '%' is whild card in mysql but do not use  who '*' use
	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'" | mysql -u root;
	# accord all priv on wordpress db to user
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE .* TO '$MYSQL_USER'@'%'" | mysql -u root;
	# update privileges
	echo "FLUSH PRIVILEGES" | mysql -u root;


	service mysql stop

	exec /usr/sbin/mysqld -u root
	```

	cf:
	```sql
	# see GRANTS for current user
	SHOW GRANTS;
	# see GRANTS for 'root_root'@'%'; 
	SHOW GRANTS FOR 'kychoi'@'%'; 
	```

	for test:
	```bash
	mkdir -p /Users/kyubongchoi/data/db_volume
	docker build -t mariadb ./srcs/requirements/mariadb
	# it doesn't work beacause i don't know yet how to manage like driver_opts in docker-compose
	sudo docker run -it --name mariadb --env-file $(pwd)/srcs/.env -p 3307:3307 -v /Users/kyubongchoi/data/db_volume:/var/lib/mysql mariadb

	# remove all docker containers, images and volumes not used
	docker system prune -fa --all --volumes
	```

	```bash
	# to get maraidb container's hostname to use in wordpress container
	hostname -i
	```
	172.19.0.2

2. Wordpress

	```bash
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get -y install \
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

	# move wordpress files to /var/www/html
	mv /usr/share/wordpress/* /var/www/html/
	# rename wp-config-sample.php to wp-config.php
	mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

	```



	2.1. Modify wordpress config

	vim /var/www/html/wp-config.php
	```php
	define('DB_NAME', 'wordpress_db') # to replace with .env
	define('DB_USER', 'kychoi') # to replace with .env
	define('DB_PASSWORD', 'Password') # to replace with .env
	define('DB_HOST', '172.23.0.4') # to replace with .env
	```

	2.2. Modify php-fpm config

	vim /etc/php/7.3/fpm/pool.d/www.conf
	```cnf
	listen = 0.0.0.0:9000

	```

	2.3 start php fpm

	```bash
	service php7.3-fpm start
	```



3.  Nginx

	3.0. install packages : nginx openssl vim

	```bash
	apt-get update -y && apt-get -y install nginx openssl vim
	```

	3.1. Create self-signed ssl

	```bash
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt
	```

	3.2. Modify default file

	vim /etc/nginx/sites-available/default
	```
	server {
		listen 443 ssl;
		ssl_protocols  TLSv1.2 TLSv1.3;
		
		ssl_certificate /etc/ssl/certs/server.crt;
		ssl_certificate_key /etc/ssl/private/server_pkey.pem;

		root /var/www/html;

		index index.php index.html index.htm;

		server_name _;

		location / {
			try_files $uri $uri/ =404;
		}

		location ~ \.php$ {
			include snippets/fastcgi-php.conf;
			
			# fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
			fastcgi_param SCRIPT_FILENAME /var/www/html/$fastcgi_script_name;
			fastcgi_pass 172.25.0.2:9000;
		}
	}

	```












3.  Wordpress

## Theory

### Base commands

0. pull

	> docker pull [DOCKER_IMAGE]
	
	```zsh
	docker pull debian # download docker image from dockerhub
	```

1. run

	> docker run [OPTION] <DOCKER_IMAGE>

	ex:
	```zsh
	docker pull debian # download docker image from dockerhub
	docker run -it debian	# run debian image with interactive mode
	```

	```zsh
	docker run --name ws -p 8000:80 -v ~/Documents/42/inception/src:/usr/local/apache2/htdocs httpd
	```


	```
	docker run --name nginx -it -v $(pwd)/srcs/requirements/nginx/conf:/etc/nginx debian
	```
	
	- `--name <CONTAINER_NAME>` : define container name

	- `-p <HOST_PORT>:<CONTAINER_PORT>`:
		- define port forwarding: in this exemple, when host receive a request to 8000 port, redirect this req to 80 port in ws container.

	- `-v <HOST_FILE_SYSYEM>:<CONTAINER_FILE_SYSTEM>`:
		- link HOST FS and CONTAINER FS
		- Thanks for this, you can edit FS in container from host.

	- `-i` : interactive mode


2. logs

	> docker logs [OPTION] <CONTAINER>


	ex:

	```zsh
	docker logs -f ws3
	```

	- `-f` : follow log output(like watch in nodemon)


3. exec

	> docker exec [OPTION] <CONTAINER> <COMMAND>

	ex01: access to current container then execute one command

	```zsh
	docker exec ws2 pwd #usr/local/appach2
	```

	ex02: open interactive shell(`bash`, `sh` ou `zsh` if container has it) in current container
	
	```zsh
	docker exec -it ws2 bash
	
	root@27290926ed14:/usr/local/apache2# pwd
	/usr/local/apache2

	```
	- `-i` : interactive, keep STDIN open even if not attached
	- `-t` : Allocate a pseudo TTY

4. start

	> docker start <CONTAINER>

5. stop

	> docker stop <CONTAINER>

6. remove container

	> docker rm <CONTAINER>


7. remove image

	> docker rmi <DOCKER_IMAGE>

8. system prune : Remove all unused containers, networks, images 

	> docker system prune -f -a


### Dockerfile & build

```
|------------|
| Dockerfile |
|------------|
        |
        | build 
        v
|--------------|
| DOCKER_IMAGE |
|--------------|
    |   ^
run |   | commit
    v   |
|------------------|
| DOCKER_CONTAINER |
|------------------|
```

- Dockerfile

```Dockerfile
FROM ubuntu
RUN apt update && apt install -y python3
WORKDIR /var/www/
COPY ["src/index.html", "."]
CMD [ "python3", "-u", "-m", "http.server" ]
```
   - `FROM` : reference image
   - `RUN` : command to execute on `build` - on image
   - `WORKDIR` : move to this directory on `build` (if not exist, create it)
   - `COPY` : copy src file to dst path
   - `CMD` : command to execute on `container`


- Build command

```bash
docker build -t web-server .; # build docker image from Dockerfile
docker rm --force ws; # when container exist, remove old container
docker run --name ws -p 8888:8000 web-server; # create/run container from docker image.
```


- docker-compose 
<img src="./docker-compose_example.png" />


### ETC


### Reference
- [docker-compose by Egoing](https://www.youtube.com/watch?v=EK6iYRCIjYs "Egoing docker-compose class")


#mysql
172.24.0.2

#wordpress
172.24.0.3

root@8b41a90ef8e8:/# apt-get update -y && \
apt-get upgrade -y && \
apt-get -y install \
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
