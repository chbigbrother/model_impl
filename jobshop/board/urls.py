# board/urls.py

from django.urls import path

from .views import ArticleList, ArticleDetail, ArticleDelete, ArticleCreate, ArticleUpdate

urlpatterns = [
    path('', ArticleList.as_view(), name='index'),
    path('create/', ArticleCreate.as_view(), name='create'),
    path('<int:pk>/', ArticleDetail.as_view(), name='detail'),
    path('<int:pk>/update/', ArticleUpdate.as_view(), name='update'),
    path('<int:pk>/delete/', ArticleDelete.as_view(), name='delete'),
]