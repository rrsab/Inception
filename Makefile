F_NONE		= \033[37m
F_BOLD		= \033[1m
F_RED		= \033[31m
F_ORANGE	= \033[38m
F_YELLOW	= \033[0;33m
F_GREEN		= \033[32m
F_CYAN		= \033[36m
F_BLUE		= \033[34m
# docker inspect "container_name" 
#   curl mariadb:9000
#	curl nginx:443

PATH_DIR = ./data ./data/db ./data/www ./data/adminer

all:generation_envfile dns-host-add
	@mkdir ${PATH_DIR} 2>/dev/null || true
	sudo docker-compose -f  srcs/docker-compose.yml build     # cобирем все
	sudo docker-compose -f  srcs/docker-compose.yml up -d 	   # запускаем в фоне

up:
	sudo docker-compose -f  srcs/docker-compose.yml up -d 

down:
	sudo docker-compose -f  srcs/docker-compose.yml down 

#### Nginx ####
enter_nginx:
	sudo docker exec -it nginx /bin/bash

### MariadDb

enter_sql:
	sudo docker exec -it mariadb /bin/bash

### wordpress 
enter_wordpres:
	sudo docker exec -it wordpress /bin/bash
# check protocol
tls:
	openssl s_client -connect 127.0.0.1:443

## Volume
volumes:
	sudo docker volume ls	

## Networks
networks:
	sudo docker network ls

## Ps
ps:
	sudo docker ps -a

pss:
	sudo docker-compose -f  srcs/docker-compose.yml ps
# Images	
images:
	sudo docker images -a

## Удаляет папку (грубо говоря Volume) и заново создаем
recreatedir:
	@sudo rm -rf ${PATH_DIR} 2>/dev/null
	@mkdir ${PATH_DIR} 2>/dev/null

## останавливает все контейнейры
stop:
	sudo docker stop $$(sudo docker ps -aq) 2>/dev/null || echo " "
## запускаем все контейнейры
start:
	sudo docker start $$(sudo docker ps -aq) 2>/dev/null || echo " "
## удаляет контейнеры
remote:
	sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || echo " "
## удаляет Volume
rm_volume:
	sudo docker volume rm $$(docker volume ls -q)  2>/dev/null || echo " "

rm_network:
	docker network rm $$(docker network ls -q) 2>/dev/null || echo " "

clean:	stop remote rm_volume  rm_network recreatedir
	sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || echo " "

fclean:	clean
	# удаляет образы
	sudo docker rmi -f $$(sudo docker images -aq) 2>/dev/null || echo " "

re:	fclean all recreatedir



NICKNAME = salyce
ENV = ./srcs/.env

dns-host-add:
	@echo "Задать доменное имя локальному сайту: ${NICKNAME}.42.fr"
	@echo "127.0.0.1 ${NICKNAME}.42.fr" | sudo tee -a /etc/hosts

# .env по умолчанию
generation_envfile:
	@echo "Generation .env"
	@>  ${ENV}
	@echo "DOMIAN_NAME=${NICKNAME}.42.fr" >> ${ENV}
	@echo "DB_WP_NAME=wordpress" >> ${ENV}
	@echo "DB_ROOT_PASSWORD=root" >> ${ENV}
	@echo "DB_ROOT_USER=root" >> ${ENV}
	@echo "DB_USER=${NICKNAME}" >> ${ENV}
	@echo "DB_USER_PASSWORD=${NICKNAME}" >> ${ENV}
	@echo "DB_HOST=mariadb" >> ${ENV}
	@echo "DB_PREFIX=wp_" >> ${ENV}
	@echo "FTP_USER=ftpsalyce" >> ${ENV}
	@echo "FTP_PASS=ftpsalyce" >> ${ENV}
	@echo "FTP_GROUP=www" >> ${ENV}

code:
	@echo " ~~~~~~~~~~~~~~~~"
	@echo "$(F_BOLD)  * Make code, *"
	@echo "$(F_BOLD)   * not war! *"
	@echo "$(F_RED)    ..10101.."
	@echo "$(F_ORANGE)  01   1   011"
	@echo "$(F_YELLOW) 10     0     00"
	@echo "$(F_GREEN) 11   .010.   11"
	@echo "$(F_CYAN) 00 .01 1 01. 10"
	@echo "$(F_BLUE) 010   1   110"
	@echo "$(F_BLUE)   11011010**$(F_NONE)"

#docker ps  — показывает список запущенных контейнеров. Некоторые из полезных флагов:
#-a / --all — список всех контейнеров (по умолчанию показывает только запущенные);
#-q / --quiet — перечислить только id контейнеров (полезно, когда вам нужны все контейнеры).

#docker stop  —  останавливает один и более контейнеров. Команда docker stop my_container остановит один контейнер, 
#а docker stop $(docker ps -a -q) — все запущенные. Более грубый способ — использовать docker kill my_container,
# который не пытается сначала аккуратно завершить процесс.

# docker rm — удаляет контейнер
# docker rmi — удаляет образ
#
#
# how use docker don't sudos
# sudo groupadd docker
# sudo gpasswd -a $USER docker
# sudo service docker restart
# sudo docker volume rm inception-volume 
# sudo docker volume rm db-volume 
