#!/bin/bash
set -e
 
docker compose down --volumes
docker rmi lamp-apache lamp-php lamp-mysql