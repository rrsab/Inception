CREATE DATABASE IF NOT EXISTS wp;
CREATE USER IF NOT EXISTS 'salyce'@'%' IDENTIFIED BY 'dbpass';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON wp.* TO 'salyce'@'%';
GRANT ALL PRIVILEGES ON wp.* TO 'root'@'%';
DELETE FROM mysql.user WHERE Password='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;


Verify whether database user was successfully created by logging in to the MariaDB console via mariadb -u <username-2> -p.

$ mariadb -u <username-2> -p
Enter password: <password-2>
MariaDB [(none)]>
Confirm whether database user has access to the database via SHOW DATABASES;.

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
Exit the MariaDB shell via exit.

MariaDB [(none)]> exit