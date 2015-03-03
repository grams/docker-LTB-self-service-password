FROM phusion/baseimage:0.9.16
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y apache2 php5 php5-mcrypt php5-ldap && apt-get clean
RUN curl http://tools.ltb-project.org/attachments/download/499/self-service-password_0.8-1_all.deb > self-service-password.deb && dpkg -i self-service-password.deb ; rm -f self-service-password.deb

RUN ln -s self-service-password /etc/apache2/sites-available/self-service-password.conf
RUN ln -s ../../mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
RUN a2dissite 000-default && a2ensite self-service-password

EXPOSE 80

