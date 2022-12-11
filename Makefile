OS_ARCH 	:= $(shell uname -m)
ifeq ($(OS_ARCH),arm64)
	OS_NAME 	:=	Mac M1
	DATA_PATH	:=	/Users/kyubongchoi/data
else
	OS_NAME 	:=	Linux
	DATA_PATH	:=	/home/kychoi/data
endif

DOCKER		=	docker

COMPOSE		=	docker-compose -f srcs/docker-compose.yml


init_dir	:
				mkdir -p $(DATA_PATH)/db_volume
				mkdir -p $(DATA_PATH)/wp_volume

build_up	:
				sudo $(COMPOSE) up --build -d

all			:	init_dir build_up

clean		:
				$(COMPOSE) down -v --rmi all --remove-orphans

fclean		:	clean
				docker system prune --volumes --all --force
				rm -rf $(DATA_PATH)
				docker network prune --force
				docker image prune --force

re			:	fclean all


#for debugging
mariadb		:
				$(COMPOSE) exec mariadb bash

wordpress	:
				$(COMPOSE) exec wordpress bash

nginx		:
				$(COMPOSE) exec nginx bash

logs		:
				$(COMPOSE) logs

