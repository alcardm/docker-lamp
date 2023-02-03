FROM php:8.2-fpm-alpine

# https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm-alpine/Dockerfile
# persistent dependencies
RUN set -eux; \
    apk add --no-cache \
    bash \
    ghostscript \
    imagemagick \
    ;

# install the PHP extensions we need (https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)
RUN set -ex; \
    \
    apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    freetype-dev \
    icu-dev \
    imagemagick-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    ; \
    \
    docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp \
    ; \
    docker-php-ext-install -j "$(nproc)" \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    zip \
    ; \
    pecl install imagick-3.6.0; \
    docker-php-ext-enable imagick; \
    rm -r /tmp/pear; \
    \
    out="$(php -r 'exit(0);')"; \
    [ -z "$out" ]; \
    err="$(php -r 'exit(0);' 3>&1 1>&2 2>&3)"; \
    [ -z "$err" ]; \
    \
    extDir="$(php -r 'echo ini_get("extension_dir");')"; \
    [ -d "$extDir" ]; \
    runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive "$extDir" \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-network --virtual .wordpress-phpexts-rundeps $runDeps; \
    apk del --no-network .build-deps; \
    \
    ! { ldd "$extDir"/*.so | grep 'not found'; }; \
    err="$(php --version 3>&1 1>&2 2>&3)"; \
    [ -z "$err" ]

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/
RUN docker-php-ext-enable opcache

# https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging
COPY error-logging.ini /usr/local/etc/php/conf.d/

# Default production configuration
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/conf.d/php.ini

# Customized configuration
COPY zzz-php.ini /usr/local/etc/php/conf.d/