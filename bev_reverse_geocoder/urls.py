from django.conf.urls import patterns, include, url
# from django.contrib import admin

urlpatterns = patterns('',
    url(r'^$', 'bev_reverse_geocoder_api.views.index', name='index'),
    url(r'^reverse-geocode/(?P<format>\w+)$', 'bev_reverse_geocoder_api.views.reverse_geocode', name='reverse_geocode'),
)
