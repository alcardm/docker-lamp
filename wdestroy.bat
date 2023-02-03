@echo off

docker compose down --volumes
docker rmi lamp-apache lamp-php lamp-mysql