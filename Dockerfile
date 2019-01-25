FROM python:3.6.7-alpine

RUN apk add gcc musl-dev postgresql-dev
RUN pip install pipenv

COPY Pipfile /
COPY Pipfile.lock /
RUN pipenv install --deploy --system

WORKDIR /app
COPY mysite/ .
