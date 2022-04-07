#!/bin/sh
service php7.3-fpm start

service php7.3-fpm stop ;

exec php-fpm7.3 --nodaemonize
