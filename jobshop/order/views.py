#-*- coding: utf-8 -*-
from django.urls import reverse_lazy
from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView, TemplateView
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.models import User, Group
from django.contrib import auth
from django.utils.encoding import smart_str
from django.db.models import Max
from django.template import loader
from rest_framework import serializers
from openpyxl import load_workbook
from fileutils.forms import FileUploadCsv
from fileutils.models import FileUploadCsv as fileUploadCsv
from company.models import Schedule, Information, Product, Facility
from common.views import id_generate, date_str, date_remove, money_count
from company.views import Product
from datetime import timedelta
from .models import *
import datetime, json, csv, math
import pandas as pd
from urllib.parse import quote

# 수주관리등록 order management register HTML
def home(request):
    template_name = 'order/order_regist.html'
    context = {
        'path': '주문정보 / 주문 등록',
        'selected': 'ordermanagement'
    }
    return render(request, template_name, context)

# 수주관리검색 order management search HTML
def order_list_view(request):
    template_name = 'order/order_list.html'

    dateFrom, dateTo, order_list = order_list_query(request)

    context = {
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'order_list': order_list,
        'path': '주문정보 / 주문 검색',
        'selected': 'ordermanagement'
    }
    return render(request, template_name, context)

def registered_order_lists(request):

    dateFrom, dateTo, order_list = order_list_query(request)
    result_list = []
    order_dict = {}
    for i in order_list:
        order_dict["order_id"] = i.order_id;
        order_dict["cust_name"] = i.cust_name;
        order_dict["prod_id"] = i.prod_id
        order_dict["amount"] = i.amount
        order_dict["exp_date"] = i.exp_date
        order_dict["sch_date"] = i.sch_date
        order_dict["contact"] = i.contact
        order_dict["email"] = i.email
        result_list.append(order_dict);


    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(result_list, default=json_default, ensure_ascii=False),
                        content_type="application/json")

def order_status(request):
    status = '1'
    user = auth.get_user(request)
    date = datetime.datetime.today()
    order_list = OrderList.objects.filter(sch_date=date.strftime("%Y%m%d")).filter(cust_name=user)
    result_dict = {}
    result_dict['user_name'] = user.username
    if len(order_list) > 0:
        dateFrom, dateTo, order_list = order_list_query(request)

        for i in order_list:
            order_status = OrderList.objects.get(order_id=i.order_id)
            status = order_status.order_status
            result_dict['status'] = status

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(result_dict, default=json_default, ensure_ascii=False),
                        content_type="application/json")

# 수주관리검색 항목 조회
def order_list_query(request):
    date = datetime.datetime.today() - timedelta(days=3)
    user = auth.get_user(request)
    group = request.user.groups.values_list('name', flat=True).first()
    group_id = request.user.groups.values_list('id', flat=True).first()
    user_name = request.user.first_name
    result_list = []

    if group == 'customer':
        if 'dateFrom' in request.GET:
            sch_date_from = datetime.datetime.strptime(request.GET['dateFrom'], "%Y-%m-%d")
            sch_date_to = datetime.datetime.strptime(request.GET['dateTo'], "%Y-%m-%d")

            date_from = request.GET['dateFrom'].replace('-', '')
            date_to = request.GET['dateTo'].replace('-', '')

            result_list = OrderList.objects.filter(sch_date__gte=date_from).filter(sch_date__lte=date_to).filter(cust_name=user_name)
        else:
            sch_date_from = date
            sch_date_to = datetime.datetime.today()
            result_list = OrderList.objects.filter(sch_date__gte=date.strftime("%Y%m%d"),
                                                  sch_date__lte=datetime.datetime.today().strftime("%Y%m%d")).filter(cust_name=user_name)
    elif group == 'admin':
        if 'dateFrom' in request.GET:
            sch_date_from = datetime.datetime.strptime(request.GET['dateFrom'], "%Y-%m-%d")
            sch_date_to = datetime.datetime.strptime(request.GET['dateTo'], "%Y-%m-%d")

            date_from = request.GET['dateFrom'].replace('-', '')
            date_to = request.GET['dateTo'].replace('-', '')

            result_list = OrderList.objects.filter(sch_date__gte=date_from).filter(sch_date__lte=date_to)
        else:
            sch_date_from = date
            sch_date_to = datetime.datetime.today()
            result_list = OrderList.objects.filter(sch_date__gte=date.strftime("%Y%m%d"),
                                                  sch_date__lte=datetime.datetime.today().strftime("%Y%m%d"))
    else:
        if 'dateFrom' in request.GET:
            sch_date_from = datetime.datetime.strptime(request.GET['dateFrom'], "%Y-%m-%d")
            sch_date_to = datetime.datetime.strptime(request.GET['dateTo'], "%Y-%m-%d")

            date_from = request.GET['dateFrom'].replace('-', '')
            date_to = request.GET['dateTo'].replace('-', '')
            order_list = OrderList.objects.filter(sch_date__gte=date_from).filter(sch_date__lte=date_to)
                # .filter(prod_id__comp_id=group_id)
            if len(order_list) > 0:
                for i in order_list:
                    product = Product.objects.filter(prod_id=i.prod_id, comp_id=group_id)
                    if len(product) > 0:
                        for j in product:
                            if i.prod_id==j.prod_id:
                                i.prod_id = j.prod_name
                                result_list.append(i)


        else:
            sch_date_from = date
            sch_date_to = datetime.datetime.today()
            order_list = OrderList.objects.filter(sch_date__gte=date.strftime("%Y%m%d"),
                                                  sch_date__lte=datetime.datetime.today().strftime("%Y%m%d"))
                # .filter(prod_id__comp_id=group_id)
            if len(order_list) > 0:
                for i in order_list:
                    product = Product.objects.filter(prod_id=i.prod_id, comp_id=group_id)
                    if len(product) > 0:
                        for j in product:
                            if i.prod_id == j.prod_id:
                                i.prod_id = j.prod_name
                                result_list.append(i)
    comp_id = []
    for i in result_list:
        i.exp_date = date_str(i.exp_date)
        i.sch_date = date_str(i.sch_date)
        fixed_status = OrderSchedule.objects.filter(order_id=i.order_id).order_by('-created_at')
        if len(fixed_status) > 0 and group != 'customer':
            schedules = Schedule.objects.get(sch_id=fixed_status[0].sch_id_id)
            if schedules.comp_id_id is not None:
                if schedules.comp_id_id!=group_id:
                    i.ord_status = 2
            if len(fixed_status) > 1 and schedules.comp_id_id==group_id:
                if fixed_status[0].use_yn == 'Y':
                    i.ord_status = 1
                else:
                    i.ord_status = 0

            if len(fixed_status) > 1 and schedules.comp_id_id!=group_id:
                i.ord_status = 2

            if len(fixed_status) <= 1 and len(fixed_status) > 0 and schedules.comp_id_id == group_id:
                if fixed_status[0].use_yn == 'Y':
                    i.ord_status = 1
                else:
                    i.ord_status = 0
            if len(fixed_status) <= 1 and len(fixed_status) > 0 and schedules.comp_id_id != group_id:
                i.ord_status = 2
        else:
            if len(fixed_status) > 1:
                if fixed_status[0].use_yn == 'Y':
                    i.ord_status = 1
                else:
                    i.ord_status = 0
            if len(fixed_status) <= 1 and len(fixed_status) > 0:
                if fixed_status[0].use_yn == 'Y':
                    i.ord_status = 1
                else:
                    i.ord_status = 0
        if len(fixed_status) == 0:
                i.ord_status = 2

    return sch_date_from.strftime("%Y-%m-%d"), sch_date_to.strftime("%Y-%m-%d"), result_list # order_list

# 수주관리검색 수정
def order_list_edit(request):
    if request.method == 'POST':
        request = json.loads(request.body)

    cust_name = request['cust_name']
    prod_name = request['prod_name']
    amount = request['amount']
    exp_date = request['exp_date']
    contact = request['contact']
    email = request['email']
    order_id = request['order_id']
    # prod_id = Product.objects.get(prod_name=prod_name)

    product = OrderList.objects.get(order_id=order_id)
    product.cust_name = cust_name
    product.prod_id = Product.objects.get(prod_name=prod_name)
    product.amount = amount
    product.exp_date = exp_date.replace('-', '').replace('-', '')
    product.contact = contact
    product.email = email

    product.save();

    return JsonResponse({"message": 'success'})

# 수주관리검색 수정
def order_list_delete(request):
    if request.method == 'POST':
        request = json.loads(request.body)
    order_id = request['order_id']
    order = OrderList.objects.get(order_id=order_id)
    order.delete();

    return JsonResponse({"message": 'success'})

# 스케쥴링실행 메뉴의 해당 주문일자 별 수주검색
def order_list_search(request):
    date = datetime.datetime.today() - timedelta(days=3)
    for i in request.GET:
        request = json.loads(i)
    order_list_result = []

    if request['dateFrom'] != None:
        date_from = request['dateFrom'].replace('-', '')
        date_to = request['dateTo'].replace('-', '')

        order_list = OrderList.objects.filter(sch_date__gte=date_from).filter(sch_date__lte=date_to)
        order_list = OrderList.objects.raw(
            "SELECT order_id, prod_id, SUM(amount) as amount " +
            "FROM order_orderlist " +
            "WHERE sch_date >= '" + date_from + "' AND " +
            "sch_date <= '" + date_to + "'" +
            "GROUP BY prod_id")
        for i in order_list:
            product_dict = {}
            product = Product.objects.filter(prod_id=i.prod_id)[0]
            # 필요 기계 대수 default 설정값 계산
            # (수량 / 일일생산량) / 2
            avail_fac_cnt = 0
            if((int(i.amount) / product.daily_prod_rate) // 2 > 0):
                avail_fac_cnt = (int(i.amount) / product.daily_prod_rate) // 2
            else:
                avail_fac_cnt = 1
            product_name = product.prod_name
            product_dict['order_id'] = i.order_id
            product_dict['prod_name'] = product_name
            product_dict['amount'] = int(i.amount)
            product_dict['avail_fac_cnt'] = avail_fac_cnt
            order_list_result.append(product_dict)
    else:
        order_list = OrderList.objects.raw(
            "SELECT order_id, prod_id, SUM(amount) as amount " +
            "FROM order_orderlist " +
            "WHERE sch_date >= '" + date.strftime("%Y%m%d") + "' AND " +
            "sch_date <= '" + datetime.datetime.today().strftime("%Y%m%d") + "'" +
            "GROUP BY prod_id")
        for i in order_list:
            product_dict = {}
            product = Product.objects.get(prod_id=i.prod_id.prod_id)
            product_name = product.prod_name
            product_dict['order_id'] = i.order_id
            product_dict['prod_name'] = product_name
            product_dict['amount'] = int(i.amount)
            order_list_result.append(product_dict)

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(order_list_result, default=json_default, ensure_ascii=False), content_type="application/json")
    # return JsonResponse(list(order_list_result.values()), safe=False)

def fixed_order(request):
    user = auth.get_user(request)
    user_name = request.user.first_name
    for i in request.GET:
        request = json.loads(i)
    date_from = request['dateFrom']
    date_to = request['dateTo']
    group_name = request['groupName']
    group_id = request['groupId']
    # user_name = request['userName']
    user_id = request['userId']

    final_result = []
    if group_name == 'customer':  # 고객
        result = OrderSchedule.objects.filter(sch_id__work_str_date__gte=date_from).filter(order_id__cust_name=user_name).filter(use_yn="Y")
        last_result = []  # 수정한 자리
        complist = []  # 수정한 자리
        for q in result:
            final_dict = {}
            final_dict['comp_name'] = q.sch_id.comp_id.comp_name  # 회사명
            final_dict['order_id'] = q.order_id.order_id  # 오더번호
            final_dict['amount'] = q.order_id.amount  # 오더수량
            final_dict['cust_name'] = user_name  # 고객명
            final_dict['sch_date'] = q.order_id.sch_date  # 주문일자
            final_dict['exp_date'] = q.order_id.exp_date  # 작업기한
            final_dict['textile_name'] = q.order_id.prod_id.prod_name  # 소재명
            final_dict['amount'] = q.order_id.amount  # 주문수량
            final_result.append(final_dict)

        order_id_check = []

        for i in range(len(final_result)):
            order_id_check.append(final_result[i]['order_id'])
        custset = set(order_id_check)
        order_id_indpt = list(custset)  # 중복제거

        for i in range(len(final_result)):
            complist.append(final_result[i]['comp_name'])
        compset = set(complist)
        complist = list(compset)  # 중복제거

        common_list = []
        for i in order_id_indpt:
            common_sub_list = []
            count = order_id_check.count(i)
            if count > 1:
                for j in range(len(final_result)):
                    if final_result[j]['order_id'] == i:
                        common_sub_list.append(final_result[j])
                common_list.append(common_sub_list)
            else:
                for j in range(len(final_result)):
                    if final_result[j]['order_id'] == i:
                        last_result.append(final_result[j])

        last_result.append(common_list)
        last_result.append(complist)
    # if len(request.user.groups.values('id')) == 0: # 회사
    if group_name != 'admin' and group_name != 'customer':
        result = OrderSchedule.objects.filter(sch_id__work_str_date__gte=date_from, use_yn='Y') \
                 | OrderSchedule.objects.filter(sch_id__work_str_date__lte=date_from, sch_id__work_end_date__gte=date_to).filter(use_yn='Y');
                # OrderSchedule.objects.filter(sch_id__work_str_date__lte=date_from, sch_id__comp_id=group_id, use_yn='Y') \
                # | OrderSchedule.objects.filter(sch_id__work_end_date__gte=date_to).filter(sch_id__comp_id=group_id, use_yn='Y');
        if len(result) > 0:
            for q in result:
                final_dict = {}
                prod_name = Product.objects.filter(prod_id=q.order_id.prod_id)[0]
                prod_name = prod_name.prod_name
                final_dict['comp_name'] = q.sch_id.comp_id.comp_name  # 회사명
                final_dict['order_id'] = q.order_id.order_id  # 오더번호
                final_dict['amount'] = q.order_id.amount  # 오더수량
                final_dict['cust_name'] = q.order_id.cust_name  # 고객명
                final_dict['sch_date'] = q.order_id.sch_date  # 주문일자
                final_dict['exp_date'] = q.order_id.exp_date  # 요청작업기한
                final_dict['work_str_date'] = q.sch_id.work_str_date
                final_dict['work_end_date'] = q.sch_id.work_end_date
                final_dict['textile_name'] = prod_name  # 소재명
                final_dict['amount'] = q.order_id.amount  # 주문수량
                final_result.append(final_dict)

            custlist = []
            for i in range(len(final_result)):
                custlist.append(final_result[i]['cust_name'])
            custset = set(custlist)
            custlist = list(custset)  # 중복제거

            complist = []
            for i in range(len(final_result)):
                complist.append(final_result[i]['comp_name'])
            compset = set(complist)
            complist = list(compset)  # 중복제거

            count = {}
            for i in range(len(final_result)):
                try:
                    count[final_result[i]['cust_name']] += 1
                except:
                    count[final_result[i]['cust_name']] = 1

            last_result = []
            one_cust = []

            if len(custlist) == 1:
                last_result.append(final_result)
                last_result.append(complist)
            else:
                for i in count:
                    if count[i] > 1: # 동일인의 주문 조회시 리스트로 합쳐서 출력
                        for q in range(len(final_result)):
                            if i == final_result[q]['cust_name']:
                                common_dict = {}
                                common_dict['cust_name'] = final_result[q]['cust_name']  # 고객명
                                common_dict['comp_name'] = final_result[q]['comp_name']  # 회사명
                                common_dict['order_id'] = final_result[q]['order_id']  # 오더번호
                                common_dict['amount'] = final_result[q]['amount']  # 오더수량
                                common_dict['sch_date'] = final_result[q]['sch_date']  # 주문일자
                                common_dict['exp_date'] = final_result[q]['exp_date']  # 작업기한
                                common_dict['work_str_date'] = final_result[q]['work_str_date']
                                common_dict['work_end_date'] = final_result[q]['work_end_date']
                                common_dict['textile_name'] = final_result[q]['textile_name']  # 소재명
                                one_cust.append(common_dict)
                            else:
                                last_result.append(final_result[q])
                        last_result.append(one_cust)
                    else:
                        final_list = []
                        for q in range(len(final_result)):
                            common_dict = {}
                            common_dict['cust_name'] = final_result[q]['cust_name']  # 고객명
                            common_dict['comp_name'] = final_result[q]['comp_name']  # 회사명
                            common_dict['order_id'] = final_result[q]['order_id']  # 오더번호
                            common_dict['amount'] = final_result[q]['amount']  # 오더수량
                            common_dict['sch_date'] = final_result[q]['sch_date']  # 주문일자
                            common_dict['exp_date'] = final_result[q]['exp_date']  # 작업기한
                            common_dict['work_str_date'] = final_result[q]['work_str_date']
                            common_dict['work_end_date'] = final_result[q]['work_end_date']
                            common_dict['textile_name'] = final_result[q]['textile_name']  # 소재명
                            # print(common_dict)
                            final_list.append(common_dict)
                    break;
                last_result.append(final_list)
                last_result.append(complist)
        else:
            return JsonResponse({"message": 'null'})
    if group_name == 'admin':  # 관리자
        result = OrderSchedule.objects.filter(sch_id__work_str_date__gte=date_from)
        for q in result:
            prod_name = Product.objects.filter(prod_id=q.order_id.prod_id)[0]
            prod_name = prod_name.prod_name
            if (q.use_yn == 'Y'):
                final_dict = {}
                final_dict['comp_name'] = q.sch_id.comp_id.comp_name  # 회사명
                final_dict['order_id'] = q.order_id.order_id  # 오더번호
                final_dict['amount'] = q.order_id.amount  # 오더수량
                final_dict['cust_name'] = q.order_id.cust_name  # 고객명
                final_dict['sch_date'] = q.order_id.sch_date  # 주문일자
                final_dict['exp_date'] = q.order_id.exp_date  # 작업기한
                final_dict['textile_name'] = prod_name  # 소재명
                final_dict['amount'] = q.order_id.amount  # 주문수량
                final_result.append(final_dict)
        custlist = []

        for i in range(len(final_result)):
            custlist.append(final_result[i]['cust_name'])
        custset = set(custlist)
        custlist = list(custset)  # 중복제거

        complist = []
        for i in range(len(final_result)):
            complist.append(final_result[i]['comp_name'])
        compset = set(complist)
        complist = list(compset)  # 중복제거
        #

        count = {}
        for i in range(len(final_result)):
            try:
                count[final_result[i]['cust_name']] += 1
            except:
                count[final_result[i]['cust_name']] = 1

        last_result = []
        one_cust = []
        for i in count:
            if count[i] > 1:
                for q in range(len(final_result)):
                    if i == final_result[q]['cust_name']:
                        common_dict = {}
                        common_dict['cust_name'] = final_result[q]['cust_name']  # 고객명
                        common_dict['comp_name'] = final_result[q]['comp_name']  # 회사명
                        common_dict['order_id'] = final_result[q]['order_id']  # 오더번호
                        common_dict['amount'] = final_result[q]['amount']  # 오더수량
                        common_dict['sch_date'] = final_result[q]['sch_date']  # 주문일자
                        common_dict['exp_date'] = final_result[q]['exp_date']  # 작업기한
                        common_dict['textile_name'] = final_result[q]['textile_name']  # 소재명
                        one_cust.append(common_dict)
                    else:
                        last_result.append(final_result[q])
                last_result.append(one_cust)
            else:
                for q in range(len(final_result)):
                    common_dict = {}
                    common_dict['cust_name'] = final_result[q]['cust_name']  # 고객명
                    common_dict['comp_name'] = final_result[q]['comp_name']  # 회사명
                    common_dict['order_id'] = final_result[q]['order_id']  # 오더번호
                    common_dict['amount'] = final_result[q]['amount']  # 오더수량
                    common_dict['sch_date'] = final_result[q]['sch_date']  # 주문일자
                    common_dict['exp_date'] = final_result[q]['exp_date']  # 작업기한
                    common_dict['textile_name'] = final_result[q]['textile_name']  # 소재명
                    # print(common_dict)
                    last_result.append(common_dict)
            break;
        last_result.append(complist)

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(last_result, default=json_default, ensure_ascii=False), content_type="application/json")

# csv file upload
def upload_file(request):
    if request.method == 'POST':
        form = FileUploadCsv(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return JsonResponse({"message": 'success'})
    else:
        form = FileUploadCsv()
    return JsonResponse({"message": request.FILES})

# 수주문서양식다운로드
def order_csv_download_blank(request):
    filename = request.user.groups.values('name')[0]['name'] + "_수주정보.csv"

    # response content type
    response = HttpResponse(
        content_type='text/csv',
        headers={'Content-Disposition': "attachment;filename*=UTF-8''{}".format(quote(filename.encode('utf-8')))},
    )

    writer = csv.writer(response, csv.excel)
    response.write(u'\ufeff'.encode('utf8'))

    # write the headers
    writer.writerow([
        smart_str(u"고객명"),
        smart_str(u"주문일자"),
        smart_str(u"마감기한"),
        smart_str(u"제품명"),
        smart_str(u"수량"),
        smart_str(u"전화번호"),
        smart_str(u"이메일"),
    ])
    return response

# Draw table after reading csv file
def order_read_csv(request):
    # readFile = request.FILES['file'];
    readFile = fileUploadCsv.objects.all().order_by('id').last()
    read = pd.read_csv('./media/' + str(readFile.file), encoding='UTF8')
    data_list = []

    # 예외처리
    # 1. 데이터 컬럼 일치하지 않을 때
    for col in read.columns:
        if '고객명' in col:
            col = read[['고객명', '주문일자', '마감기한', '제품명', '수량', '전화번호', '이메일']]
            for row in range(int(col.size / 7)):
                data_dict = {}
                data_dict['cust_name'] = str(col.loc[[row], ['고객명']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['sch_date'] = str(col.loc[[row], ['주문일자']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['exp_date'] = str(col.loc[[row], ['마감기한']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['prod_name'] = str(col.loc[[row], ['제품명']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['amount'] = str(col.loc[[row], ['수량']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['contact'] = str(col.loc[[row], ['전화번호']].values).replace('[', '').replace(']', '').replace("'", '')
                data_dict['email'] = str(col.loc[[row], ['이메일']].values).replace('[', '').replace(']', '').replace("'", '')
                data_list.append(data_dict)
    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(data_list, default=json_default, ensure_ascii=False), content_type="application/json")

# Draw table after delete the data
def order_delete_read_csv(request):

    if request.method == 'POST':
        request = json.loads(request.body)
        name = request['name']
        amount = request['amount']
        fileName = request['fileName']

    read = pd.read_csv('./media/' + fileName, encoding='UTF8')
    data_list = []

    # 예외처리
    # 1. 데이터 컬럼 일치하지 않을 때
    for col in read.columns:
        if '고객명' in col:
            col = read[['고객명', '주문일자', '마감기한', '제품명', '수량', '전화번호', '이메일']]
            for row in range(int(col.size / 7)):
                if str(col.loc[[row], ['고객명']].values).replace('[', '').replace(']', '').replace("'", '') == name and str(col.loc[[row], ['수량']].values).replace('[', '').replace(']', '').replace("'", '') == amount:
                    continue;
                else:
                    data_dict = {}
                    data_dict['cust_name'] = str(col.loc[[row], ['고객명']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['sch_date'] = str(col.loc[[row], ['주문일자']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['exp_date'] = str(col.loc[[row], ['마감기한']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['prod_name'] = str(col.loc[[row], ['제품명']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['amount'] = str(col.loc[[row], ['수량']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['contact'] = str(col.loc[[row], ['전화번호']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_dict['email'] = str(col.loc[[row], ['이메일']].values).replace('[', '').replace(']', '').replace("'", '')
                    data_list.append(data_dict)
    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(data_list, default=json_default, ensure_ascii=False), content_type="application/json")


# Save data into the Database by reading csv file
def order_update_csv(request):
    if request.method == 'POST':
        for i in range(len(request.POST.getlist('cust_name'))):
            # id generator
            id_count = OrderList.objects.all().order_by('order_id').last()
            if id_count is None:
                int_id = 0
            else:
                int_id = id_count.order_id[3:]
            str_id = id_generate('ORD', int_id)
            prod_name = Product.objects.get(prod_name=request.POST.getlist('prod_name')[i])
            OrderList.objects.create(
                order_id=str_id,
                cust_name=request.POST.getlist('cust_name')[i],
                sch_date=request.POST.getlist('sch_date')[i],
                exp_date=request.POST.getlist('exp_date')[i],
                prod_id=Product.objects.get(prod_id=prod_name.prod_id),
                amount=request.POST.getlist('amount')[i],
                contact=request.POST.getlist('contact')[i],
                email=request.POST.getlist('email')[i],
            )

    return redirect("/order/list/")

# Save data into the Database from modal elements
def order_update_modal(request):
    if request.method == 'POST':
        # 'cust_name': '박영희', 'sch_date': '2022-02-24', 'exp_date': ['2022-03-18'], 'demands': ['33650'], 'prod_name': ['collapse-0'], 'contact': '2022-01-10', 'email': '2022-01-01'
        request = json.loads(request.body)
    order_list = []

    for i in range(len(request['demands'])):
        order_dict = {}
        order_dict['cust_name'] = request['cust_name']
        order_dict['sch_date'] = request['sch_date']
        order_dict['contact'] = request['contact']
        order_dict['email'] = request['email']
        # id_generator
        id_count = OrderList.objects.all().order_by('order_id').last()
        if id_count is None:
            int_id = 0
        else:
            int_id = id_count.order_id[3:]
        str_id = id_generate('ORD', int_id)
        prod_name = Product.objects.filter(prod_name=request['prod_name'][i])
        prod_name = prod_name[0]
        prod_id = prod_name.prod_id
        OrderList.objects.create(
            order_id=str_id,
            cust_name=request['cust_name'],
            sch_date=date_remove(request['sch_date']),
            exp_date=date_remove(request['exp_date'][i]),
            prod_id=prod_id,
            amount=request['demands'][i],
            contact=request['contact'],
            email=request['email'],
        )
        order_dict['prod_name'] = prod_name.prod_name;
        order_dict['exp_date'] = request['exp_date'][i];
        order_dict['demands'] = request['demands'][i];
        order_list.append(order_dict);

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(order_list, default=json_default, ensure_ascii=False), content_type="application/json")

def avail_comps(request):
    for i in request.GET:
        request = json.loads(i)

    order_id = request['order_id']
    date_from = request['date_from'].replace('-', '')
    date_to = request['date_to'].replace('-', '')

    result_list = []
    data_list = OrderSchedule.objects.filter(sch_id__work_str_date__gte=date_from, sch_id__work_str_date__lte=date_to, use_yn="N", order_id=order_id)
    order_list = OrderList.objects.get(order_id=order_id)

    for i in data_list:
        result_dict = {}
        comp_info = Schedule.objects.get(sch_id=i.sch_id_id)
        product_list = Product.objects.filter(prod_id=order_list.prod_id, comp_id=comp_info.comp_id_id)
        cred = Information.objects.get(comp_id=comp_info.comp_id_id)
        exp_date = Schedule.objects.filter(sch_id=i.sch_id_id)
        for j in exp_date:
            result_dict['exp_date'] = j.work_end_date
        result_dict['comp_name'] = cred.comp_name
        for j in product_list:
            result_dict['cost'] = money_count(j.cost)
            result_dict['prod_name'] = j.prod_name
        result_dict['order_id'] = i.order_id_id
        result_dict['credibility'] = cred.credibility
        result_list.append(result_dict)

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(result_list, default=json_default, ensure_ascii=False),
                        content_type="application/json")

def product_lists(request):
    result = Product.objects.all()
    result_list = []
    result_dict = {}
    for i in result:
        result_list.append(i.prod_name)

    rst_set = set(result_list)
    result_list = list(rst_set)
    final = []
    for i in result_list:
        product = Product.objects.filter(prod_name=i)[0]
        result_dict = {}
        result_dict['prod_id'] = product.prod_id
        result_dict['prod_name'] = i
        final.append(result_dict)

    def json_default(value):
        if isinstance(value, datetime.date):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(final, default=json_default, ensure_ascii=False), content_type="application/json")

def order_test(request):


    return JsonResponse({"message": 'error'})
