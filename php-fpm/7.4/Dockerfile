FROM php:7.4-fpm

# make system calls non interactive
ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get -y update \ 
 && apt-get -y install zip unzip cron curl tzdata gosu

# add smoothy group
RUN groupadd --gid 1000 smoothy \
 && useradd smoothy --shell /bin/bash --uid 1000 --create-home --gid 1000 --groups tty

# install php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions \
    bcmath \
    bz2 \
    exif \
    gd \
    imagick \
    imap \
    intl \
    memcached \
    opcache \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    redis \
    shmop \
    soap \
    zip

# copy php configuration
RUN rm /usr/local/etc/php/php.ini-*
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# copy php fpm configuration
RUN rm -f /usr/local/etc/php-fpm.d/*
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# create directory for php fpm socket
RUN mkdir -p /var/run/php-fpm \
 && chown -R smoothy:smoothy /var/run/php-fpm

# install composer
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

# cleanup
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY run.sh /run.sh
RUN mkdir -p /entrypoints \
 && chown :smoothy /entrypoints \
 && chmod g+s /entrypoints

RUN chown --recursive :smoothy /var/www/html \
 && chmod g+s /var/www/html \
 && chmod --recursive 775 /var/www/html

ENTRYPOINT ["bash", "/run.sh"]

CMD ["/usr/local/sbin/php-fpm", "-c", "/usr/local/etc/php-fpm.d/www.conf"]