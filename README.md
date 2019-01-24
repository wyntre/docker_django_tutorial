# docker_django_tutorial

## What's needed?
https://docs.djangoproject.com/en/2.1/
https://docs.docker.com/compose/gettingstarted/

## On Ubuntu
sudo apt install python3 python3-pip

## In the repositiory directory
pipenv --three --python $(python3 --version | awk '{ print $2 }')
