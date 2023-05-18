# order/urls.py

from django.urls import path

from .views import *
app_name = 'recommend'
urlpatterns = [
    path('', home, name='recommend.home'),
]