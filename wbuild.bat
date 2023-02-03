@echo off

docker compose up -d --build
 
docker exec apache chown -R root:www-data /usr/local/apache2/logs
docker exec php chown -R root:www-data /usr/local/etc/logs
rem docker exec mysql chown -R root:www-data /var/log/mysql