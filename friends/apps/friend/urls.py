from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index),
    url(r'^success$', views.success),
    url(r'^registration$', views.registration),
    url(r'^login$', views.login),
    url(r'^logout$', views.logout),
    url(r'^addfriend/(?P<id>\d+)$', views.addfriend),
    url(r'^remove/(?P<id>\d+)$', views.remove),
    url(r'^profile/(?P<id>\d+)$', views.profile),
]
