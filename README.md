# docker_django_tutorial

## What's needed?
* https://docs.djangoproject.com/en/2.1/
* https://docs.docker.com/compose/gettingstarted/

## Django Tutorial
* https://docs.djangoproject.com/en/2.1/intro/tutorial02/

## Using PostgresSQL instead of SQLite
```shell
pipenv shell
pipenv install psycopg2
```

### mysite/mysite/settings.py
Replace:
```python
# Database
# https://docs.djangoproject.com/en/2.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

With:
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}
```

### Dockerfile
```dockerfile
FROM python:3.6.7-alpine

COPY Pipfile /
COPY Pipfile.lock /
RUN apk add gcc musl-dev postgresql-dev \
    && pip install pipenv \
    && pipenv install --deploy --system \
    && apk del gcc musl-dev postgresql-dev

WORKDIR /app
COPY ./mysite/ .

COPY ./django-start.sh /usr/local/bin/
```

### django-start.sh
```bash
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
```

### docker-compose.yml
```yaml
version: '3'
services:
  db:
    image: postgres
  mysite:
    build: .
    command: django-start.sh
    ports:
      - "8000:8000"
    volumes:
      - ./mysite:/app
    depends_on:
      - db
```

## Create a superuser for the database
```shell
docker-compose run mysite python manage.py createsuperuser
```

This will prompt you to enter a username, email address and password for in the /admin/ section of the django app.

http://localhost:8000/admin/
