# docker_django_tutorial

## What's needed?
* https://docs.djangoproject.com/en/2.1/
* https://docs.docker.com/compose/gettingstarted/

## Django Tutorial
https://docs.djangoproject.com/en/2.1/intro/tutorial06/

## Docker
No changes need for docker files.

## mysite/mysite/settings.py
Add to the end of the file.
```python
...
STATIC_ROOT = (os.path.join(os.path.dirname(__file__), '..', 'static'))
STATICFILES_DIR = (os.path.join(BASE_DIR, "static"), )
```

## mysite/mysite/urls.py
```python
from django.contrib import admin
from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
```

## Restart mysite
```shell
docker-compose restart mysite
```
