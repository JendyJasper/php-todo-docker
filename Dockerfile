#use the php image that comes with apache
FROM php:7.2-apache

#a multi stage build. This gets the composer image and copies the binary file to a different direct
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

#copy all the files from the root directory to the jenkins file
COPY . /var/www/html/


RUN apt-get -y update

RUN apt-get install zip -y
RUN apt-get install unzip -y
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN apt-get -y install git

RUN composer install

WORKDIR /var/www/html

#change the server name to localhost on the apache conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#migrate the database
RUN php artisan migrate

#copy the custom apache config file which grants access to the /var/www/html/public directory where the index file is
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
#CMD ["php", "artisan", "serve"]

#start apache
RUN apachectl start
