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

    - hacky patch(not recommanded)

    - host, --link, links
            
        > `network` must be defined in `docker-compose.yml`

    - `infinity loop` such as while true...


## Program

1.  S1

    1-1. S1-1

    1-1-1. S1-1-1

2.  S2

## Theory

### Base commands

1. run

    > docker run [OPTION] <DOCKER_IMAGE>

    ex:

    ```zsh
    docker run --name ws -p 8000:80 -v ~/Documents/42/inception/src:/usr/local/apache2/htdocs httpd
    ```
    
    - `--name <CONTAINER_NAME>` : define container name

    - `-p <HOST_PORT>:<CONTAINER_PORT>`:
        - define port forwarding: in this exemple, when host receive a request to 8000 port, redirect this req to 80 port in ws container.

    - `-v <HOST_FILE_SYSYEM>:<CONTAINER_FILE_SYSTEM>`:
        - link HOST FS and CONTAINER FS
        - Thanks for this, you can edit FS in container from host.

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
