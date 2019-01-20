FROM php:5.6.39-fpm

ARG USER_ID=1000
ARG GROUP_ID=50

EXPOSE 9000

RUN groupdel staff \
 && groupadd -f -o -g $GROUP_ID staff \
 && useradd -m -s /bin/bash -u $USER_ID -g staff docker

RUN apt-get update && apt-get install -y \
        libbz2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install bz2 calendar exif gettext mbstring mcrypt mysqli pdo_mysql sockets zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd

ADD php-fpm.conf /usr/local/etc

