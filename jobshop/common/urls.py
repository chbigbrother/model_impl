from django.urls import path, include
from django.contrib.auth import views as auth_views

app_name = 'common'

urlpatterns = [
    path('login/', auth_views.LoginView.as_view(template_name='../templates/main/login.html'), name='login'),
]