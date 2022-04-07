FROM debian:buster


## Update system and download mariadb
RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y procps && \
    apt-get install net-tools && \
    apt-get install curl -y


# Перекидываем файл конфигурации
# говорим что слушаем всех говорим порт и настривам Volume
COPY ./conf/my.cnf /etc/mysql/my.cnf
RUN chmod 444 /etc/mysql/my.cnf

##  Тоже различные настройки
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 444 etc/mysql/mariadb.conf.d/50-server.cnf

# Скрипт потом для запуска 
#COPY ./tools/mariadb_start.sh /bin/mariadb_start.sh
EXPOSE 3306

ARG DB_ROOT_PASSWORD
ARG DB_USER_PASSWORD
ARG DB_USER
ENV DB_WP_NAME=${DB_WP_NAME}
ENV DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
ENV DB_USER_PASSWORD=${DB_USER_PASSWORD}
ENV DB_USER=${DB_USER}


#RUN chmod +x    ./db.sh

# ENTYPOINT точка входа CMD аргументы
# sh -c 

#ENTRYPOINT ["./db.sh"] 

COPY ./tools/setup.sh /bin/setup.sh
RUN chmod 755 /bin/setup.sh

CMD sh /bin/setup.sh
#CMD exec mysqld_safe

#mysql -u root -h mariadb -p