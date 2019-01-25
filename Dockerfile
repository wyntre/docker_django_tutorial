FROM python:3.6.7-alpine

RUN pip install pipenv

COPY Pipfile /
COPY Pipfile.lock /
RUN pipenv install --deploy --system

WORKDIR /app
COPY mysite/ .
