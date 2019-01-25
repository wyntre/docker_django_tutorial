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
