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
# Display version information
RUN composer --version
RUN apt-get update && apt-get -y install wget cron
# Add crontab file in the cron directory
ADD crontab /etc/cron.d/jobby
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/jobby
# Create the log file to be able to run tail
RUN touch /var/log/cron.log
# Run the command on container startup
RUN service cron restart
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*