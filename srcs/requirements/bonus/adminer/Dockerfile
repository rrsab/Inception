FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN	apt-get install -y php-fpm php-mysql

RUN mkdir -p /var/www/html/adminer/
COPY ./tools/adminer.php /var/www/html/adminer/index.php
RUN chown -R www-data:www-data /var/www/html

COPY ./conf/php-fpm.conf /etc/php/7.3/fpm/
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/adminer_start.sh /

CMD sh adminer_start.sh