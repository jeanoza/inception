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

- T1


### ETC


### Reference

```

```
