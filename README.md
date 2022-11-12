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






2. DO NOT use:

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

1. run

    ```zsh
    docker run --name ws -p 8080:80 httpd
    
    ```
    
    - `--name <name>` : define container name

    - -`p <port>:<port>`:
        - define port forwarding: in this exemple, when host receive a request to 8080 port, redirect this req to 80 port in ws container.
    


### ETC


### Reference

```

```
