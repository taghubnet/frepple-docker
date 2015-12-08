#!/bin/sh
frepplectl migrate --noinput
frepplectl runserver 0.0.0.0:8000
