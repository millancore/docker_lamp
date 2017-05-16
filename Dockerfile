FROM ubuntu:14.04

MAINTAINER Juan Millan version: 0.1

ENV DEBIAN_FRONTEND noninteractive

# Install PHP 5.5
RUN apt-get update && apt-get install -y \
  apache2 \
  libapache2-mod-php5 \
  curl \
  git \
  php5-cli \
  php5 \
  php5-mcrypt \
  php5-curl \
  php5-pgsql \
  php5-mysql \
  php5-intl 
  
# Setup Composer
RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer

# Activate a2enmod
RUN a2enmod rewrite

# Override default apache conf
ADD api.conf /etc/apache2/sites-enabled/000-default.conf

RUN echo "ServerName localhost" |tee /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn

# Set Apache environment variables (can be changed on docker run with -e)
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2

ADD /data/ssh_key/key.pem /ssh/key.pem
RUN chmod 400 /ssh/key.pem

RUN mkdir dumpdb

EXPOSE 80