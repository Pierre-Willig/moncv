# Define OS
FROM debian:bullseye-slim
# WebServer Apache2
RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/www/moncv/
COPY ./site /var/www/moncv/
# Define perms
RUN chown -R www-data:www-data /var/www/moncv
COPY ./moncv.conf /etc/apache2/sites-available/moncv.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN  a2dissite 000-default.conf && a2ensite moncv.conf && a2enmod rewrite
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
