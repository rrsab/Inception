#!/bin/sh

check=$(find /var/www/html -name index.php | wc -l)

service php7.3-fpm start

if [ $check -eq "0" ] ;
then
#service php7.3-fpm start

# Скачеваем установочные файлы
wp core download    --allow-root --locale=ru_RU --path="/var/www/html"

# Подключение к базе данных
wp core config	--allow-root \
				--skip-check \
				--dbname=$DB_WP_NAME \
				--dbuser=$DB_USER \
				--dbpass=$DB_USER_PASSWORD \
				--dbhost=$DB_HOST \
				--dbprefix=$DB_PREFIX \
				--path="/var/www/html"

# Устанавливаем и создаем администратора
wp core install	--allow-root \
				--url=$DOMAIN_NAME \
				--title="school 21" \
				--admin_user="salyce" \
				--admin_password="salyce" \
				--admin_email="salyce@student.21-school.ru" \
				--path="/var/www/html"


# Создаем еще 2 пользователей
wp user create      ramil ramil@salyce.42.com \
                    --role=author \
                    --user_pass="ramil" \
                    --allow-root \
					--path="/var/www/html"

wp user create      ivan ivan@salyce.42.com \
                    --role=author \
                    --user_pass="ivan" \
                    --allow-root \
					--path="/var/www/html"



#  Без этих записей не подгружеат таблицу стилей и остальной контент
sed "2idefine('WP_HOME','https://$DOMAIN_NAME');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_SITEURL','https://$DOMAIN_NAME');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php

sed "2idefine('WP_REDIS_HOST', 'redis');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_REDIS_PORT', 6379);" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_REDIS_TIMEOUT', 1);" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_REDIS_READ_TIMEOUT', 1);" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_REDIS_DATABASE', 0);" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_CACHE_KEY_SALT', 'redis');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php

# Устанавливаем и активируем плагин redis
wp plugin install redis-cache --allow-root --path="/var/www/html"
wp plugin activate redis-cache --allow-root --path="/var/www/html"

#mv /redis-cache /var/www/html/wp-content/plugins/

# Запускаем сервис чтобы создался сокет-файл, отлчючаем и запускаем на переднем плане
#service php7.3-fpm stop ;

fi

service php7.3-fpm stop ;

exec php-fpm7.3 --nodaemonize
