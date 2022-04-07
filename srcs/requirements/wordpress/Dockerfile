FROM debian:buster

#RUN apt-get update
# Устанавливаем php и php-fpm, а так-же инструмент curl 
# (альтернатива для нашего случая wget)
# Чтобы скачать и установить wp-cli
RUN apt-get update && apt-get upgrade -y
RUN	apt-get install -y php-fpm php-mysql
RUN apt-get install -y curl

# Скачиваем wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Даем права на испольнения и переносить в /usr/local/bin/ 
# чтобы можно было исполнить из любой точки
# оболочки
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Подготовим место для wordpress файлов
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

ARG DB_ROOT_PASSWORD
ARG DB_USER_PASSWORD
ARG DB_USER
ENV DB_WP_NAME=${DB_WP_NAME}
ENV DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
ENV DB_USER_PASSWORD=${DB_USER_PASSWORD}
ENV DB_USER=${DB_USER}
COPY ./conf/php-fpm.conf /etc/php/7.3/fpm/
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Установить wordpress в указанную директорию

COPY ./tools/wordpress_start.sh /

CMD sh wordpress_start.sh
