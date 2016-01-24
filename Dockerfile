# FrePPLe binaries are compiled for Ubuntu 14.04
FROM ubuntu:14.04

# Update environment
RUN apt-get -y -q update
RUN apt-get -y install python3 python3-pip wget
RUN apt-get -y install libxerces-c3.1 apache2 libapache2-mod-wsgi-py3 python3-psycopg2

# Install frePPle
ADD resources/ /resources
WORKDIR /resources
RUN pip3 install -r requirements.txt
RUN dpkg -i frepple_*.deb
RUN apt-get -f -y -q install

# Configure apache web server
RUN a2enmod expires
RUN a2enmod wsgi
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN a2ensite frepple

# Expose HTTP and HTTPS ports to the outside world
EXPOSE 80 443

# Create the database schema and start apache
ADD settings.py /etc/frepple/djangosettings.py
ADD start.sh /usr/bin/startfrepple
CMD ["startfrepple"]
