FROM viison/debian:wheezy

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  curl \
  ca-certificates \
  git \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  php5-fpm \
  php5-cli \
  php5-mysqlnd \
  php5-sqlite \
  php5-intl \
  php5-curl \
  php5-gd \
  php5-mcrypt \
  php5-imagick \
  php-soap \
 && rm -rf /var/lib/apt/lists/*

RUN curl -L http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz | tar xzf - \
 && cp ioncube/ioncube_loader_lin_5.4.so /usr/lib/php5/20100525/ioncube.so \
 && echo "zend_extension = /usr/lib/php5/20100525/ioncube.so" > /etc/php5/fpm/conf.d/00-ioncube.ini \
 && echo "zend_extension = /usr/lib/php5/20100525/ioncube.so" > /etc/php5/cli/conf.d/00-ioncube.ini \
 && rm -rf ioncube

RUN sed -i 's/^;\?daemonize =.*/daemonize = no/g' /etc/php5/fpm/php-fpm.conf \
 && sed -i 's/^;\?date.timezone =.*/date.timezone = Europe\/Berlin/g' /etc/php5/fpm/php.ini \
 && sed -i 's/^.*short_open_tag\s=.*$/short_open_tag = On/g' /etc/php5/fpm/php.ini \
 && sed -i 's/^.*post_max_size\s=.*$/post_max_size = 100M/g' /etc/php5/fpm/php.ini \
 && sed -i 's/^.*upload_max_filesize\s=.*$/upload_max_filesize = 100M/g' /etc/php5/fpm/php.ini \
 && sed -i 's/^.*memory_limit\s=.*$/memory_limit = 512M/g' /etc/php5/fpm/php.ini \
 && sed -i 's/^.*max_execution_time\s=.*$/max_execution_time = 3600/g' /etc/php5/fpm/php.ini

RUN curl https://getcomposer.org/installer 2>/dev/null | php -- --install-dir="/usr/local/bin/" --filename="composer"

EXPOSE 9000

CMD ["php5-fpm"]
