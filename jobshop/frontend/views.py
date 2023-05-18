from django.shortcuts import render
from django.http.response import HttpResponse
import datetime, json
from datetime import timedelta

# Create your views here.
def index(request):
    template_name = 'main/index.html'

    dateFrom, dateTo = get_dates(request)

    context = {
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'path': '대시보드',
        'selected': 'ordermanagement'
    }
    return render(request, template_name, context)

def get_dates(request):
    date = datetime.datetime.today() - timedelta(days=3)

    if 'dateFrom' in request.GET:
        date_from = datetime.datetime.strptime(request.GET['dateFrom'], "%Y-%m-%d")
        date_to = datetime.datetime.strptime(request.GET['dateTo'], "%Y-%m-%d")
    else:
        date_from = date
        date_to = datetime.datetime.today()

    return date_from.strftime("%Y-%m-%d"), date_to.strftime("%Y-%m-%d")
# board
def board(request):
    return render(request, 'main/board.html')

# login
# def login(request):
#     return render(request, 'main/login.html')

# logout
def logout(request):
    return render(request, 'common/logout.html')

# nav 메뉴
def nav(request):
    return render(request, 'common/nav.html')

# topbar - 검색 바
def topbar(request):
    return render(request, 'common/topbar.html')

# footer
def footer(request):
    return render(request, 'common/footer.html')

# compregist
def company(request):
    return render(request, 'company/comp_regist.html')

# compregist
def test(request):
    return render(request, 'test.html')

