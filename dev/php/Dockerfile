FROM php:5.6-cli

ARG USER_ID=1000
ARG GROUP_ID=50

RUN groupdel staff \
 && groupadd -f -o -g $GROUP_ID staff \
 && useradd -m -s /bin/bash -u $USER_ID -g staff docker

RUN apt-get update && apt-get install -y \
        libbz2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install bz2 exif gettext mbstring mysqli pdo_mysql sockets zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug
