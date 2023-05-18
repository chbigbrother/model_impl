# schedule/urls.py

from django.urls import path

from .views import *
app_name = 'schedule'
urlpatterns = [
    path('', home, name='schedule.index'),
    path('history/', history, name='schedule.history'),
    path('confirmed/', sch_confirmed, name='schedule.sch_confirmed'),
    path('confirmed/monthly/', monthly_confirmed_order, name='schedule.monthly_confirmed_order'),
    path('history/chart/<str:id>/<str:schDate>/', history_chart, name='schedule.history_chart'),
    path('history/graph/chart/', draw_history_chart, name='draw_history_chart'),
    path('graph/csv/generate/', generate_data, name='generate_data'),
    path('graph/draw/', draw_graph, name='draw_graph'),
    path('avail/comp/', available_comp, name='available_comp'),
    path('test/data/', test_data, name='test_data'),
    path('fixed/order/', fixed_order, name='fixed_order'),
    path('confirmed/order/', confirmed_order, name='confirmed_order'),
    path('delete/order/', delete_order, name='delete_order'),
    path('schedule/history/', schedule_history, name='schedule_history'),
    # path('create/', ArticleCreate.as_view(), name='create'),
    # path('<int:pk>/', ArticleDetail.as_view(), name='detail'),
    # path('<int:pk>/update/', ArticleUpdate.as_view(), name='update'),
    # path('<int:pk>/delete/', ArticleDelete.as_view(), name='delete'),
]