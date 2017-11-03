FROM viison/debian:jessie

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  curl \
  ca-certificates \
  apt-transport-https \
  git \
 && rm -rf /var/lib/apt/lists/*

RUN curl --silent --output /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
 && echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list \
 && apt-get update \
 && apt-get install --no-install-recommends -y \
  php7.1-fpm \
  php7.1-cli \
  php7.1-mysql \
  php7.1-sqlite3 \
  php7.1-intl \
  php7.1-curl \
  php7.1-gd \
  php7.1-mcrypt \
  php7.1-imagick \
  php7.1-xml \
  php7.1-soap \
  php7.1-mbstring \
  php7.1-zip \
  php7.1-bcmath \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz | tar xzf - \
 && cp ioncube/ioncube_loader_lin_7.1.so /usr/lib/php/20160303/ioncube.so \
 && echo "zend_extension = /usr/lib/php/20160303/ioncube.so" > /etc/php/7.1/fpm/conf.d/00-ioncube.ini \
 && echo "zend_extension = /usr/lib/php/20160303/ioncube.so" > /etc/php/7.1/cli/conf.d/00-ioncube.ini \
 && rm -rf ioncube

RUN sed -i 's/^;\?daemonize =.*/daemonize = no/g' /etc/php/7.1/fpm/php-fpm.conf \
 && sed -i 's/^;\?date.timezone =.*/date.timezone = Europe\/Berlin/g' /etc/php/7.1/fpm/php.ini \
 && sed -i 's/^.*short_open_tag\s=.*$/short_open_tag = On/g' /etc/php/7.1/fpm/php.ini \
 && sed -i 's/^.*post_max_size\s=.*$/post_max_size = 100M/g' /etc/php/7.1/fpm/php.ini \
 && sed -i 's/^.*upload_max_filesize\s=.*$/upload_max_filesize = 100M/g' /etc/php/7.1/fpm/php.ini \
 && sed -i 's/^.*memory_limit\s=.*$/memory_limit = 512M/g' /etc/php/7.1/fpm/php.ini \
 && sed -i 's/^.*max_execution_time\s=.*$/max_execution_time = 3600/g' /etc/php/7.1/fpm/php.ini

RUN curl https://getcomposer.org/installer 2>/dev/null | php -- --install-dir="/usr/local/bin/" --filename="composer"

EXPOSE 9000

CMD ["php-fpm7.1"]
