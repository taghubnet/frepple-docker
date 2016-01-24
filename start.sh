#!/bin/sh

echo "Migrate the database schema"
frepplectl migrate --noinput

echo "Running the apache web server"
rm -f /usr/local/apache2/logs/httpd.pid
. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND

