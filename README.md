# docker-lamp

A template with Apache, PHP-FPM and MySQL on Docker.

Includes _WordPress_ dependencies and _opcache_ enabled.

Use _git_ to clone this repository `git clone https://github.com/alcardm/docker-lamp.git`

## Import database before start

Copy sql file to _docker/mysql_ folder. Uncomment this lines on _docker/mysql/Dockerfile_; replace password, database file name and database name.

```dockerfile
ENV MYSQL_ROOT_PASSWORD=${LAMP_MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${LAMP_MYSQL_DATABASE}

COPY database.sql /docker-entrypoint-initdb.d/init.sql
```

## Starting

Run `docker compose up -d --build`

On linux you can use `./build.sh` to bring your this stack online (to make it executable use `chmod +x build.sh`).

On Windows use `wbuild.bat`.

## Stoping

Run `docker compose down --volumes`

On linux you can use `./destroy.sh` to... shutdown (to make it executable use `chmod +x destroy.sh`).

On Windows use `wdestroy.bat`.

⚠ Keep in mind that the this script also deletes the images created.

## Where to place files

You can place your files and folders anywhere in the _/public_ folder.

## How to access your projects?

Access project by browsing to [http://localhost](http://localhost) and it will use your public folder as the default location.

## phpMyAdmin

Access with MySQL user and password through [http://localhost:81](http://localhost:81). Database storage will be saved at _/dbdata_ folder. You could setup phpMyAdmin configuration storage to activate extended features.

---

## Resources

- [inanzzz | Creating Apache, MySQL and PHP-FPM containers for a web application with Docker compose](http://www.inanzzz.com/index.php/post/su76/creating-apache-mysql-and-php-fpm-containers-for-a-web-application-with-docker-compose)
- [iamgoodbytes/docker-LAMP-starter: A starter template if you want to get up and running quickly with php/mysql/apache in Docker (github.com)](https://github.com/iamgoodbytes/docker-LAMP-starter)
- [wordpress/Dockerfile at master · docker-library/wordpress (github.com)](https://github.com/docker-library/wordpress/blob/master/latest/php7.4/fpm-alpine/Dockerfile)
- [Mysql - Official Image | Docker Hub](https://hub.docker.com/_/mysql)
- [Phpmyadmin - Official Image | Docker Hub](https://hub.docker.com/_/phpmyadmin)
