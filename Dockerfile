FROM debian:buster-slim

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install --no-install-suggests -y ca-certificates php7.3-fpm php7.3-common php7.3-mysql php7.3-zip php7.3-gd php7.3-mbstring php-imagick imagemagick

RUN echo "[www]" > /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "user = www-data" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "group = www-data" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "listen = 0.0.0.0:9000" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "listen.owner = www-data" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "listen.group = www-data" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "pm = dynamic" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "pm.max_children = 5" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "pm.start_servers = 2" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "pm.min_spare_servers = 1" >> /etc/php/7.3/fpm/pool.d/www.conf \
    && echo "pm.max_spare_servers = 3" >> /etc/php/7.3/fpm/pool.d/www.conf

RUN echo "daemonize = no" > /etc/php/7.3/fpm/php-fpm.conf \
    && echo "include=/etc/php/7.3/fpm/pool.d/*.conf" >> /etc/php/7.3/fpm/php-fpm.conf
RUN echo "max_execution_time = 200" >> /etc/php/7.3/fpm/php.ini \
    && echo "post_max_size = 100M" >> /etc/php/7.3/fpm/php.ini \
    && echo "upload_max_filesize = 20M" >> /etc/php/7.3/fpm/php.ini \
    && echo "memory_limit = 256M" >> /etc/php/7.3/fpm/php.ini

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
CMD ["php-fpm7.3"]
