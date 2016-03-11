FROM freyrus/base-php5.6

MAINTAINER gialac <gialacmail@gmail.com>

# install mongodb driver for php
RUN pecl install mongo
RUN echo "extension=mongo.so" >> /etc/php5/fpm/php.ini

ADD .               /var/www
WORKDIR             /var/www
USER www-data

#RUN composer install

EXPOSE 80

# Clean up APT when done.
USER root
ADD vhost   /etc/nginx/sites-available/default
#RUN /etc/init.d/nginx restart
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*