#!/bin/bash
set -e
 
docker compose up -d --build
 
docker exec apache chown -R root:www-data /usr/local/apache2/logs
docker exec php chown -R root:www-data /usr/local/etc/logs
# docker exec mysql chown -R root:www-data /var/log/mysql