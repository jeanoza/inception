OS_ARCH 	:= $(shell uname -m)
ifeq ($(OS_ARCH),arm64)
	OS_NAME 	:=	Mac M1
	DATA_PATH	:=	/Users/kyubongchoi/data
else
	OS_NAME 	:=	Linux
	DATA_PATH	:=	/home/kychoi/data
endif

DOCKER		=	sudo docker

COMPOSE		=	sudo docker compose -f srcs/docker-compose.yml

HOSTS_PATH	=	/etc/hosts

init_dir	:
				mkdir -p $(DATA_PATH)/db_volume
				mkdir -p $(DATA_PATH)/wp_volume
				sudo chmod 777 $(HOSTS_PATH)
				echo "127.0.0.1 kychoi.42.fr" >> $(HOSTS_PATH)

build_up	:
				$(COMPOSE) up --build -d

all			:	init_dir build_up

clean		:
				$(COMPOSE) down -v --rmi all --remove-orphans

fclean		:	clean
				$(DOCKER) system prune --volumes --all --force
				sudo rm -rf $(DATA_PATH)
				$(DOCKER) network prune --force
				$(DOCKER) image prune --force
				sudo sed -i '/kychoi/d' /etc/hosts

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

