FROM viison/debian:jessie

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  curl \
  ca-certificates \
  git \
 && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 89DF5277 \
 && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install --no-install-recommends -y \
  php7.0-fpm \
  php7.0-cli \
  php7.0-mysql \
  php7.0-sqlite3 \
  php7.0-intl \
  php7.0-curl \
  php7.0-gd \
  php7.0-mcrypt \
  php7.0-imagick \
  php7.0-xml \
  php7.0-soap \
  php7.0-mbstring \
  php7.0-zip \
 && rm -rf /var/lib/apt/lists/*

RUN curl http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz | tar xzf - \
 && cp ioncube/ioncube_loader_lin_7.0.so /usr/lib/php/20151012/ioncube.so \
 && echo "zend_extension = /usr/lib/php/20151012/ioncube.so" > /etc/php/7.0/fpm/conf.d/00-ioncube.ini \
 && echo "zend_extension = /usr/lib/php/20151012/ioncube.so" > /etc/php/7.0/cli/conf.d/00-ioncube.ini \
 && rm -rf ioncube

RUN sed -i 's/^;\?daemonize =.*/daemonize = no/g' /etc/php/7.0/fpm/php-fpm.conf \
 && sed -i 's/^;\?date.timezone =.*/date.timezone = Europe\/Berlin/g' /etc/php/7.0/fpm/php.ini \
 && sed -i 's/^.*short_open_tag\s=.*$/short_open_tag = On/g' /etc/php/7.0/fpm/php.ini \
 && sed -i 's/^.*post_max_size\s=.*$/post_max_size = 100M/g' /etc/php/7.0/fpm/php.ini \
 && sed -i 's/^.*upload_max_filesize\s=.*$/upload_max_filesize = 100M/g' /etc/php/7.0/fpm/php.ini \
 && sed -i 's/^.*memory_limit\s=.*$/memory_limit = 512M/g' /etc/php/7.0/fpm/php.ini \
 && sed -i 's/^.*max_execution_time\s=.*$/max_execution_time = 3600/g' /etc/php/7.0/fpm/php.ini

RUN curl https://getcomposer.org/installer 2>/dev/null | php -- --install-dir="/usr/local/bin/" --filename="composer"

EXPOSE 9000

CMD ["php-fpm7.0"]
