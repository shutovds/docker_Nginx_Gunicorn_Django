#!/bin/sh

if [ "$DB_HOST" = "db" ] 
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done
fi

sleep 0.1
echo "...PostgreSQL started"

python ./mysite/manage.py flush --no-input
python ./mysite/manage.py migrate
python ./mysite/manage.py collectstatic --noinput


exec "$@"
