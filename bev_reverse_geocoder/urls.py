from django.conf.urls import include, url
from bev_reverse_geocoder_api.views import index, reverse_geocode
# from django.contrib import admin

urlpatterns = [
    url(r'^$', index, name='index'),
    url(r'^reverse-geocode/(?P<format>\w+)$', reverse_geocode, name='reverse_geocode'),
]
