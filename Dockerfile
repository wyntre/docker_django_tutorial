FROM python:3.6.7-alpine

COPY mysite/requirements.txt /
RUN pip install -r /requirements.txt

WORKDIR /app
COPY mysite/ .

EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]
