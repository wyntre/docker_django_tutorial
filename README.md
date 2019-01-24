# docker_django_tutorial

## What's needed?
* https://docs.djangoproject.com/en/2.1/
* https://docs.docker.com/compose/gettingstarted/

## On Ubuntu
```shell
sudo apt install python3 python3-pip
sudo pip3 install pipenv
```

## In the repositiory directory
```shell
pipenv --three --python $(python3 --version | awk '{ print $2 }')
pipenv install django
```

### Verify django
```shell
python -m django --version
```

## Enter virtual environment
```shell
pipenv shell
```

Follow https://docs.djangoproject.com/en/2.1/intro/tutorial01/

Once you can reach the server at http://localhost:8000, let's move this over to Docker using docker-compose

## Adding Docker
Create Dockerfile
```dockerfile
FROM python:3.6.7-alpine

COPY mysite/requirements.txt /
RUN pip install -r /requirements.txt

WORKDIR /app
COPY mysite/ .

EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]
```

Create .dockerignore
```
docker-compose.yml
```

Create docker-compose.yml
```
version: '3'
services:
  mysite:
    build: .
    ports:
      - "8000:8000"
```

Run docker-compose up
* you can add --build to force it to rebuild if it doesn't work the first time
```
wyntre@thelio:~/extra/github/docker_django_tutorial$ docker-compose up --build
Building mysite
Step 1/7 : FROM python:3.6.7-alpine
 ---> cb04a359db13
Step 2/7 : COPY requirements.txt /
 ---> bb925c2143a8
Step 3/7 : RUN pip install -r /requirements.txt
 ---> Running in a26437a39a8d
Collecting django==2.1.5 (from -r /requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/36/50/078a42b4e9bedb94efd3e0278c0eb71650ed9672cdc91bd5542953bec17f/Django-2.1.5-py3-none-any.whl (7.3MB)
Collecting pytz==2018.9 (from -r /requirements.txt (line 3))
  Downloading https://files.pythonhosted.org/packages/61/28/1d3920e4d1d50b19bc5d24398a7cd85cc7b9a75a490570d5a30c57622d34/pytz-2018.9-py2.py3-none-any.whl (510kB)
Installing collected packages: pytz, django
Successfully installed django-2.1.5 pytz-2018.9
You are using pip version 18.1, however version 19.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Removing intermediate container a26437a39a8d
 ---> 750398df757e
Step 4/7 : WORKDIR /app
 ---> Running in 87e4798b4f73
Removing intermediate container 87e4798b4f73
 ---> 73962e668d9b
Step 5/7 : COPY mysite/ .
 ---> 19a890957011
Step 6/7 : EXPOSE 8000
 ---> Running in ac547ccb0d4e
Removing intermediate container ac547ccb0d4e
 ---> 97c472dde627
Step 7/7 : CMD ["python","manage.py","runserver","0.0.0.0:8000"]
 ---> Running in a30d11e6053a
Removing intermediate container a30d11e6053a
 ---> f68e55a7f57d
Successfully built f68e55a7f57d
Successfully tagged docker_django_tutorial_mysite:latest
Recreating docker_django_tutorial_mysite_1 ... done
```
