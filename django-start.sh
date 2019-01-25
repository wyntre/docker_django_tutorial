#!/bin/sh

# Collect static files
echo "Collect static files"
python manage.py collectstatic --noinput

echo "Create polls migration"
python manage.py makemigrations polls

# Apply database migrations
echo "Apply database migrations"
python manage.py migrate

echo "Start django"
python manage.py runserver 0.0.0.0:8000
