if [ ! -d "/var/lib/mysql/wordpress" ]; then 
    
    mysql_install_db
    service mysql start
    
    mysql -u root -e "CREATE USER '${DB_USER}'@'localhost' identified by '${DB_PASSWORD}';" &&\
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;" &&\
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" &&\
    mysql -u root -e "FLUSH PRIVILEGES;"
    service mysql stop 
fi
#sleep 5
#mysqld