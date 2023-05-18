from django.shortcuts import render
from django.db.models import Max
from django.db.models.aggregates import Count
from django.contrib.auth.models import User, Group
from django.http import JsonResponse
from django.http.response import HttpResponse
from .sslstm import sslstm
from common.views import id_generate, date_str, calc_date_str, comma_str, date_remove
from company.models import *
from order.models import *
import pandas as pd
import json, csv, os, datetime, calendar, random
from datetime import timedelta
from calendar import monthrange
from bson import json_util
from random import randint

now = datetime.datetime.now()
# 스케쥴링실행 Execute Schedule HTML
def home(request):
    date = datetime.datetime.today() - timedelta(days=3)
    date = {
        'dateFrom': date.strftime("%Y-%m-%d"),
        'path': '스케쥴링 / 스케쥴링실행'
    }
    return render(request, 'schedule/schedule.html', date)

# 스케쥴링이력 Schedule history HTML
def history(request):
    date = datetime.datetime.today() - timedelta(days=3)
    if 'dateFrom' in request.GET:
        sch_date_from = datetime.datetime.strptime(request.GET['dateFrom'], "%Y-%m-%d")
        sch_date_to = datetime.datetime.strptime(request.GET['dateTo'], "%Y-%m-%d")

        date_from = request.GET['dateFrom'].replace('-', '')
        date_to = request.GET['dateTo'].replace('-', '')
        schedule_list = Schedule.objects.raw(
            " SELECT sch_id, SUBSTRING(sch_id, 4, 8) as exe_date, max(COUNT) as max_count " +
            " FROM company_schedule " +
            " WHERE SUBSTRING(sch_id, 4, 8) >= '" + date_from + "' AND "
                    "SUBSTRING(sch_id, 4, 8) <= '" + date_to + "'" +
            ' GROUP BY STR_TO_DATE(created_at, "%%Y-%%m-%%d")')
    else:
        sch_date_from = date
        sch_date_to = datetime.datetime.today()
        schedule_list = Schedule.objects.raw(
            "SELECT *, SUBSTRING(sch_id, 4, 8) as exe_date, max(COUNT) as max_count " +
            "FROM company_schedule " +
            "WHERE SUBSTRING(sch_id, 4, 8) >= '" + date.strftime("%Y%m%d") + "' AND "
            "SUBSTRING(sch_id, 4, 8) <= '" + datetime.datetime.today().strftime( "%Y%m%d") + "'" +
            ' GROUP BY STR_TO_DATE(created_at, "%%Y-%%m-%%d")')

    sch_list = []
    order_id = ''
    for sch in schedule_list:
        sch_dict = {}
        sch_dict['max_count'] = sch.max_count
        sch_dict['exe_date'] = date_str(sch.exe_date)
        sch_dict['work_end_date'] = date_str(sch.work_end_date)
        sch_dict['date_from'] = sch_date_from.strftime("%Y-%m-%d")
        sch_dict['date_to'] = sch_date_to.strftime("%Y-%m-%d")
        order_list = OrderList.objects.filter(prod_id=sch.prod_id)
        if len(order_list) == 0:
            continue;
        order_id = date_str(sch.exe_date)

        for i in order_list:
            sch_dict['sch_date'] = date_str(i.sch_date)

        sch_dict['orderid'] = order_id
        sch_list.append(sch_dict)

    date = {
        'dateFrom': sch_date_from.strftime("%Y-%m-%d"),
        'dateTo': sch_date_to.strftime("%Y-%m-%d"),
        'path': '스케쥴링 / 스케쥴링이력',
        'sch_list' : sch_list
    }
    return render(request, 'schedule/sch_history.html', date)

# 스케쥴링이력 간트차트 Schedule history in Gantt Chart HTML
def history_chart(request, id, schDate):
    date = datetime.datetime.today() - timedelta(days=3)

    date = {
        'dateFrom': date.strftime("%Y-%m-%d"),
        'id' : id,
        'schDate' : schDate,
        'path': '스케쥴링 / 스케쥴링이력',
    }
    return render(request, 'schedule/sch_history_chart.html', date)

# 스케쥴링이력 간트차트 그리기
def draw_history_chart(request):

    for i in request.GET:
        request = json.loads(i)

    id = request['orderId'] # 스케줄일자
    schDate = request['schDate'] # 주문일자

    sch_list, count = schedule_list(id, schDate)

    result = {}
    result_list = []
    final_list = []

    for cnt in range(int(count)+1):
        result['max_count'] = int(cnt)+1
        for sch in sch_list:
            product = Product.objects.filter(prod_id=sch.prod_id)[0]
            if sch.count == int(cnt)+1:
                result_dict = {}
                result_dict['facility_id'] = sch.facility_id.facility_name
                result_dict['prod_name'] = product.prod_name
                result_dict['order_id_num'] = sch.order_id_num
                result_dict['count'] = sch.count
                result_dict['sch_color'] = sch.sch_color
                result_dict['x_axis_1'] = sch.x_axis_1
                result_dict['x_axis_2'] = sch.x_axis_2
                result_dict['y_axis_1'] = sch.y_axis_1
                result_dict['work_str_date'] = date_str(sch.work_str_date)
                result_dict['work_end_date'] = date_str(sch.work_end_date)
                result_list.append(result_dict)
        result['chart_draw'] = result_list
    final_list.append(result)

    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    return HttpResponse(json.dumps(final_list, default=json_default, ensure_ascii=False), content_type="application/json")

# 확정 스케쥴 Fixed Schedule HTML
def sch_confirmed(request):
    date = datetime.datetime.today()
    date = date.strftime("%Y%m%d")
    year = date[0:4]
    month = date[4:6]

    lastday = calendar.monthrange(int(year), int(month))[1]
    final_result = OrderSchedule.objects.filter(sch_id__work_end_date__gte=date, use_yn='Y')
    available_list = []
    for i in final_result:
        available_dict = {}
        available_dict['work_str_date'] = date_str(i.sch_id.work_str_date)
        available_dict['work_end_date'] = date_str(i.sch_id.work_end_date)
        available_dict['order_id'] = i.order_id_id
        orderlist = OrderList.objects.get(order_id=i.order_id_id)
        available_dict['sch_date'] = date_str(orderlist.sch_date)
        available_dict['sch_id'] = i.sch_id
        available_list.append(available_dict)

    date = {
        'order_list': available_list,
        'path': '스케쥴링 / 확정스케쥴조회'
    }
    return render(request, 'schedule/sch_confirmed.html', date)

def schedule_list(id, schDate):

    date_from = id.replace('-', '')

    schedule_list = Schedule.objects.raw(
        "SELECT * " +
        "FROM company_schedule " +
        "WHERE SUBSTRING(sch_id, 4, 8) = '" + date_from + "' ")

    count = Schedule.objects.raw(
        ' SELECT sch_id, MAX(COUNT) as count ' +
        ' FROM company_schedule' +
        ' WHERE SUBSTRING(sch_id, 4, 8) = "' + date_from + '"')
    sch_list = []
    for i in schedule_list:
        sch_list.append(i)
    for j in count:
        count = j.count

    return sch_list, count


# 수락한 오더 리스트 조회 (월별)
def monthly_confirmed_order(request):
    date = datetime.datetime.today().strftime("%Y%m")
    for i in request.GET:
        request = json.loads(i)
    available_list = []

    if request['str_year'] != None:
        str_year = request['str_year']
        str_month = request['str_month']
        end_year = request['end_year']
        end_month = request['end_month']

        final_result = OrderSchedule.objects.filter(sch_id__work_end_date__lte=str(end_year) + str(end_month) + '31', use_yn='Y')
    else:
        year = date[0:4]
        month = date[4:6]
        lastday = calendar.monthrange(int(year), int(month))[1]
        final_result = OrderSchedule.objects.filter(sch_id__work_str_date__gte=date + '01').filter(
            sch_id__work_end_date__lte=date + str(lastday), use_yn='Y')

    for i in final_result:
        available_dict = {}
        available_dict['work_str_date'] = i.sch_id.work_str_date
        available_dict['work_end_date'] = i.sch_id.work_end_date
        available_dict['order_id'] = i.order_id_id
        available_dict['sch_id'] = i.sch_id_id
        available_list.append(available_dict)

    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')
    # return JsonResponse(list(available_list), safe=False)
    return HttpResponse(json.dumps(available_list, default=json_default, ensure_ascii=False), content_type="application/json")

# draw Gantt Chart data
def draw_graph(request):
    count = Schedule.objects.filter(comp_id=request.user.groups.values('id')[0]['id'],
                                    created_at__year=now.year, created_at__month=now.month, created_at__day=now.day)
    count = count.aggregate(Max('count'))
    print(now.year, ' / ', now.month, ' / ', now.day+1)
    for i in Group.objects.all():
        for j in Group.objects.filter(name=i).values():
            schedule_list = Schedule.objects.filter(count=count['count__max'],
                                    created_at__year=now.year, created_at__month=now.month, created_at__day=now.day)
            schedule_list = list(schedule_list.values())
    for i in range(len(schedule_list)):
        fac_name = Facility.objects.get(facility_id=schedule_list[i]['facility_id_id'])
        schedule_list[i]['work_str_date'] = date_str(schedule_list[i]['work_str_date'])
        schedule_list[i]['work_end_date'] = date_str(schedule_list[i]['work_end_date'])
        schedule_list[i]['y_axis_1'] = fac_name.facility_name
        product = Product.objects.get(prod_id=schedule_list[i]['prod_id'])
        schedule_list[i]['prod_name'] = product.prod_name


    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    print(json.dumps(schedule_list, default=json_default))
    return HttpResponse(json.dumps(schedule_list, default=json_default))

# JSSP 스케쥴링 실행
# x, y 축 저장 Save x, y axis into Database
# def generate_data(request):
#     # 회사 아이디를 얻기 위한 유저 정보
#     user_id = request.user.groups.values('id')[0]['id']
#     data = open("./schedule/dytech/new_coming.csv", "w", newline="", encoding="UTF-8")
#     product_list = []   # 제품 리스트 (Queryset 담기)
#     product_name_list = []  # 제품명 리스트
#     facility_list = []  # 기계 리스트 (Queryset 담기)
#     avail_list = []     # 사용 가능한 기계 대수
#     exp_list = []
#     column = []
#     rows = ["작업 호기", "제품명", "실제 기계 밀도", "RPM", "생산량(YD)"]
#     column.append(rows)
#
#     # POST 로 받아온 값 dict 로 담기
#     if request.method == 'POST':
#         request = json.loads(request.body)
#         ord = request['ord']    # 제품명
#         fac = request['fac']    # 기계호기
#         amt = request['amt']    # 오더 수량
#         work_str = date_remove(request['work_str_date'])        # 작업시작일자
#         work_exp_date = request['work_exp_date']                # 작업종료일자
#
#     # new_coming.csv 파일 생성
#     writer = csv.writer(data)
#     # 제품 정보 가져오기
#     for i in ord:
#         product_name = Product.objects.get(prod_name=i)
#         product_name = product_name.prod_name
#         product_list.append(Product.objects.get(prod_name=i))
#         product_name_list.append(product_name)
#
#     # 선택한 기계 정보 가져오기
#     for f in range(len(fac)):
#         avail_fac_num = len(fac[f])
#         facility_list = []
#         for j in fac[f]:
#             facility_name = Facility.objects.get(facility_id=j.replace('호기', ''))
#             facility_name = facility_name.facility_name
#             facility_list.append(facility_name)
#         # 기계 대수만큼 리스트에 넣기
#         avail_fac_list = []
#         for k in range(avail_fac_num):
#             avail_fac_list.append(facility_list[k])
#         avail_rand_list = avail_fac_list
#         for i in range(avail_fac_num):
#             days = int(amt[f]) // product_list[f].daily_prod_rate
#             work_div_days = days * 3  # 오전, 오후, 야간
#             demands = int(amt[f]) // work_div_days  # 수량과, 일일생산량, 작업반에 따른 하루 한 작업반의 작업 수량
#             demands_rest = int(amt[f]) % work_div_days  # 수량과, 일일생산량, 작업반에 따른 하루 한 작업반의 나머지 수량
#             count = 0;
#             for j in range(days):  # 5
#                 for h in range(3):  # 오전, 오후, 야간
#                     count = count + 1;
#                     if count > work_div_days:
#                         break;
#                     else:
#                         if count == work_div_days:
#                             rows = []
#                             rows.append(avail_rand_list[i])  # 작업 호기
#                             rows.append(product_list[f].prod_name)  # 제품명
#                             rows.append(product_list[f].density)  # 실제 기계 밀도
#                             rows.append(product_list[f].rpm)  # RPM
#                             rows.append(demands + demands_rest)  # 생산량(YD)
#                             column.append(rows)
#                         else:
#                             rows = []
#                             rows.append(avail_rand_list[i])  # 작업 호기
#                             rows.append(product_list[f].prod_name)  # 제품명
#                             rows.append(product_list[f].density)  # 실제 기계 밀도
#                             rows.append(product_list[f].rpm)  # RPM
#                             rows.append(demands)  # 생산량(YD)
#                             column.append(rows)
#
#     # 리스트 형식의 데이터가 있는 경우 루프를 돌려서 입력 가능
#     for col in column:
#         writer.writerow(col)
#
#     data.close()
#     result = sslstm(request)  # ss-lstm 실행
#
#     # 회사명, 취급 섬유 유형 종류, 오더한 사람이 요청한 섬유 유형 종류
#     count = Schedule.objects.filter()
#     count = Schedule.objects.filter(created_at__year=now.year, created_at__month=now.month, created_at__day=now.day)
#     count = count.aggregate(Max('count'))
#     count = str(count['count__max'])
#
#     if count == 'None':
#         count = '0'
#
#     keys_list = []  # 'color', 'order_id_num', 'machine_num', 'x1', 'y1'
#     for i in result.keys():
#         keys_list.append(i)
#
#     s_list = []
#     for i in range(len(result['color'])):
#         line = []
#         for keys in keys_list:
#             line.append(result[keys][i])
#         s_list.append(line)
#
#     # sch_id  comp_id  facility_id  count  order_id_num  x_axis_1  y_axis_1  work_str_date   work_end_date
#     for i in range(len(product_name_list)):
#         for j in range(len(s_list)):
#             # print(i, ' , ', product_name_list[i], product_name_list[int(s_list[j][2][:1]) - 1])
#             if product_name_list[i] == product_name_list[int(s_list[j][2][:1]) - 1]:
#                 sch_id_cnt = len(Schedule.objects.all())
#                 exp_date = work_exp_date[i]
#                 product_id = Product.objects.get(prod_name=product_name_list[i])
#                 y_axis = s_list[j][6]
#                 Schedule.objects.update_or_create(
#                     sch_id='SCH' + s_list[j][0] + str(int(sch_id_cnt) + 1),
#                     facility_id=Facility.objects.get(facility_name=y_axis),
#                     comp_id=Information.objects.get(comp_id=user_id),
#                     prod_id=product_id.prod_id,
#                     count=int(count) + 1,
#                     sch_color=s_list[j][1],
#                     order_id_num=s_list[j][2],  # 추후 오더 데이터에서 가져오기
#                     x_axis_1=s_list[j][4],
#                     x_axis_2=s_list[j][5],
#                     y_axis_1=y_axis,
#                     work_str_date=work_str,
#                     work_end_date=date_remove(exp_date)
#                 )
#
#
#
#     return JsonResponse({"message": 'success'})

def generate_data(request):
    print("requested!")
    # 회사 아이디를 얻기 위한 유저 정보
    user_id = request.user.groups.values('id')[0]['id']
    data = open("./schedule/dytech/prediction.csv", "w", newline="", encoding="UTF-8")
    product_list = []   # 제품 리스트 (Queryset 담기)
    product_name_list = []  # 제품명 리스트
    facility_list = []  # 기계 리스트 (Queryset 담기)
    avail_list = []     # 사용 가능한 기계 대수
    exp_list = []
    column = []
    rows = ["total processing time", "machine numbers", "machine ID", "name of product"]
    column.append(rows)

    # POST 로 받아온 값 dict 로 담기
    if request.method == 'POST':
        request = json.loads(request.body)
        ord = request['ord']    # 제품명
        fac = request['fac']    # 기계호기
        amt = request['amt']    # 오더 수량
        work_str = date_remove(request['work_str_date'])        # 작업시작일자
        work_exp_date = request['work_exp_date']                # 작업종료일자

    # new_coming.csv 파일 생성
    writer = csv.writer(data)
    # 제품 정보 가져오기
    for i in ord:
        product_name = Product.objects.filter(prod_name=i)[0]
        product_name = product_name.prod_name
        product_list.append(Product.objects.filter(prod_name=i)[0])
        product_name_list.append(product_name)

    # 선택한 기계 정보 가져오기
    for f in range(len(fac)):
        avail_fac_num = len(fac[f])
        facility_list = []
        for j in fac[f]:
            facility_name = Facility.objects.get(facility_id=j.replace('호기', ''))
            facility_name = facility_name.facility_name
            facility_list.append(facility_name)
        # 기계 대수만큼 리스트에 넣기
        avail_fac_list = []
        for k in range(avail_fac_num):
            avail_fac_list.append(facility_list[k])
        avail_rand_list = avail_fac_list
        for i in range(avail_fac_num):
            days = int(amt[f]) // product_list[f].daily_prod_rate
            work_div_days = days * 3  # 오전, 오후, 야간
            print("schedule: ", int(amt[f]) / ((product_list[f].rpm * 40 * 0.95) // product_list[f].density))
            demands = int(amt[f]) // work_div_days  # 수량과, 일일생산량, 작업반에 따른 하루 한 작업반의 작업 수량
            demands_rest = int(amt[f]) % work_div_days  # 수량과, 일일생산량, 작업반에 따른 하루 한 작업반의 나머지 수량
            count = 0;
            for j in range(days):  # 5
                for h in range(3):  # 오전, 오후, 야간
                    count = count + 1;
                    if count > work_div_days:
                        break;
                    else:
                        if count == work_div_days:
                            rpm = product_list[f].rpm
                            density = product_list[f].density
                            demands_all = demands + demands_rest
                            processing_time = round(((((rpm * 40 * 0.95)/ density) / demands_all) * 24)/10, 2)
                            rows = []
                            rows.append(h)
                            rows.append(processing_time)  # processing time = (((rpm * 40 * 0.95)/ density) / demands) * 24
                            rows.append(len(avail_rand_list))  # machine numbers
                            rows.append(avail_rand_list[i])  # machine ID
                            rows.append(product_list[f].prod_name)  # 제품명
                            column.append(rows)
                        else:
                            rpm = product_list[f].rpm
                            density = product_list[f].density
                            demands_all = demands
                            processing_time = round(((((rpm * 40 * 0.95)/ density) / demands_all) * 24)/10, 2)
                            rows = []
                            rows.append(h)
                            rows.append(processing_time)  # processing time = (((rpm * 40 * 0.95)/ density) / demands) * 24
                            rows.append(len(avail_rand_list))  # machine numbers
                            rows.append(avail_rand_list[i])  # machine ID
                            rows.append(product_list[f].prod_name)  # 제품명
                            column.append(rows)

    # 리스트 형식의 데이터가 있는 경우 루프를 돌려서 입력 가능
    for col in column:
        writer.writerow(col)

    data.close()
    result = sslstm(request)  # ss-lstm 실행

    # 회사명, 취급 섬유 유형 종류, 오더한 사람이 요청한 섬유 유형 종류
    count = Schedule.objects.filter()
    count = Schedule.objects.filter(created_at__year=now.year, created_at__month=now.month, created_at__day=now.day)
    count = count.aggregate(Max('count'))
    count = str(count['count__max'])

    if count == 'None':
        count = '0'

    keys_list = []  # 'color', 'order_id_num', 'machine_num', 'x1', 'y1'
    for i in result.keys():
        keys_list.append(i)

    s_list = []
    for i in range(len(result['color'])):
        line = []
        for keys in keys_list:
            line.append(result[keys][i])
        s_list.append(line)

    # sch_id  comp_id  facility_id  count  order_id_num  x_axis_1  y_axis_1  work_str_date   work_end_date
    for i in range(len(product_name_list)):
        for j in range(len(s_list)):
            # print(i, ' , ', product_name_list[i], product_name_list[int(s_list[j][2][:1]) - 1])
            if product_name_list[i] == product_name_list[int(s_list[j][2][:1]) - 1]:
                sch_id_cnt = len(Schedule.objects.all())
                exp_date = work_exp_date[i]
                product_id = Product.objects.filter(prod_name=product_name_list[i])[0]
                y_axis = s_list[j][6]
                Schedule.objects.update_or_create(
                    sch_id='SCH' + s_list[j][0] + str(int(sch_id_cnt) + 1),
                    facility_id=Facility.objects.get(facility_name=y_axis),
                    comp_id=Information.objects.get(comp_id=user_id),
                    prod_id=product_id.prod_id,
                    count=int(count) + 1,
                    sch_color=s_list[j][1],
                    order_id_num=s_list[j][2],  # 추후 오더 데이터에서 가져오기
                    x_axis_1=s_list[j][4],
                    x_axis_2=s_list[j][5],
                    y_axis_1=y_axis,
                    work_str_date=work_str,
                    work_end_date=date_remove(exp_date)
                )



    return JsonResponse({"message": 'success'})


# 처리 가능 오더 리스트 표출
def available_comp(request):
    result = available_list(request)

    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')
    # print(json.dumps(schedule_list, default=json_default))
    return HttpResponse(json.dumps(result, default=json_default))

# 처리 가능 오더 리스트 추출 (작업 완료 기한 기준)
def available_list(request):
    color_list = []
    final_list = []
    dict_list = []
    result = []
    now = datetime.datetime.now();
    # 당일 확정 스케쥴 존재 시
    if len(fixed_list(request, request.user.groups.values('id')[0]['id']))>0:
        for i in fixed_list(request, request.user.groups.values('id')[0]['id']):
            if i['use_yn'] == 'Y' and i['schedule'] is not None:
                for j in i['schedule']:
                    product_ids = j['prod_id']
                    product_id = Product.objects.get(prod_id=product_ids)
                    order_id = OrderList.objects.filter(prod_id=product_ids)
                    order_num = ''
                    comma_list = []
                    for k in order_id.values():
                        comma_list.append(k['order_id'])

                    prod_name = product_id.prod_name
                    j['prod_id'] = prod_name
                    j['order_id_num'] = comma_str(comma_list)
                    j['use_yn'] = i['use_yn']
                    result.append(j)
            else:
                sch_list = Schedule.objects.filter(comp_id=request.user.groups.values('id')[0]['id'],
                                                   created_at__year=now.year, created_at__month=now.month,
                                                   created_at__day=now.day)
                count = sch_list.aggregate(Max('count'))
                count = str(count['count__max'])

                print('sch_list', sch_list)

                sch_list = Schedule.objects.filter(comp_id=request.user.groups.values('id')[0]['id'],
                                                   created_at__year=now.year, created_at__month=now.month,
                                                   created_at__day=now.day, count=count)
                date_diff = calc_date_str(sch_list[0].work_str_date, sch_list[0].work_end_date)

                available_list = Schedule.objects.raw(
                    'SELECT sch_color, sch_id FROM company_schedule WHERE x_axis_2 < ' + str(date_diff.days) +
                    ' AND x_axis_2 < ' + str(date_diff.days) + ' AND count=' + count +
                    ' AND comp_id=' + str(request.user.groups.values('id')[0]['id']) +
                    ' AND STR_TO_DATE(created_at, "%%Y-%%m-%%d")= "' + now.strftime('%Y-%m-%d') + '"' +
                    ' AND prod_id NOT IN (SELECT prod_id FROM company_schedule WHERE (x_axis_2 >' + str(date_diff.days) +
                    ' OR x_axis_1 >' + str(date_diff.days) + ')' +
                    ' AND count= ' + count + ' AND comp_id=' + str(request.user.groups.values('id')[0]['id']) +
                    ') GROUP BY sch_color')

                color_list = []
                final_list = []
                dict_list = []
                result = []
                test_list = []
                for p in available_list:
                    test_list.append(p)
                    color_list.append(p.sch_color)

                for tst in test_list:
                    test = Schedule.objects.get(sch_id=tst.sch_id)
                    color = Schedule.objects.filter(sch_id=tst.sch_id, comp_id=request.user.groups.values('id')[0]['id'])
                    color.group_by = ['sch_color']
                    final_list.append(color.aggregate(Max('sch_id')))

                for i in range(len(final_list)):
                    dict_list.append(final_list[i]['sch_id__max'])

                for i in dict_list:
                    schedule_list = Schedule.objects.filter(sch_id=i)
                    result.append(list(schedule_list.values()))

                for i in range(len(result)):
                    product_ids = result[i][0]['prod_id']
                    product_id = Product.objects.get(prod_id=product_ids)
                    order_id = OrderList.objects.filter(prod_id=product_ids)
                    comma_list = []
                    for j in order_id.values():
                        comma_list.append(j['order_id'])

                    prod_name = product_id.prod_name
                    result[i][0]['prod_id'] = prod_name
                    result[i][0]['order_id_num'] = comma_str(comma_list)


    else:
        # 당일 확정 스케쥴이 존재하지 않을 때
        sch_list = Schedule.objects.filter(comp_id=request.user.groups.values('id')[0]['id'],
                                        created_at__year=now.year, created_at__month=now.month, created_at__day=now.day)

        if len(sch_list) > 0:
            count = sch_list.aggregate(Max('count'))
            count = str(count['count__max'])
            sch_list = Schedule.objects.filter(comp_id=request.user.groups.values('id')[0]['id'],
                                        created_at__year=now.year, created_at__month=now.month, created_at__day=now.day, count=count)

            date_diff = calc_date_str(sch_list[0].work_str_date, sch_list[0].work_end_date)

            available_list = Schedule.objects.raw(
                ' SELECT sch_color, sch_id FROM company_schedule WHERE ' +
                ' x_axis_2 < ' + str(date_diff.days) + ' AND count=' + count +
                ' AND comp_id=' + str(request.user.groups.values('id')[0]['id']) +
                ' AND STR_TO_DATE(created_at, "%%Y-%%m-%%d")= "' + now.strftime('%Y-%m-%d') + '"'+
                ' AND prod_id NOT IN (SELECT prod_id FROM company_schedule WHERE ' +
                ' STR_TO_DATE(created_at, "%%Y-%%m-%%d")= "' + now.strftime('%Y-%m-%d') + '"' +
                ' AND count= ' + count + ' AND comp_id=' + str(request.user.groups.values('id')[0]['id']) +
                ' AND (x_axis_2 >' + str(date_diff.days) + ' OR x_axis_1 >' + str(date_diff.days) + ')'
                ') GROUP BY sch_color')

            for p in available_list:
                color_list.append(p.sch_color)

            for i in color_list:
                # color = Schedule.objects.raw('SELECT * FROM company_schedule WHERE sch_color = "' +  i + '" GROUP BY sch_color HAVING MAX(sch_id)')
                color = Schedule.objects.filter(sch_color=i, comp_id=request.user.groups.values('id')[0]['id'])
                final_list.append(color.aggregate(Max('sch_id')))

            for i in range(len(final_list)):
                dict_list.append(final_list[i]['sch_id__max'])

            for i in dict_list:
                schedule_list = Schedule.objects.filter(sch_id=i)
                result.append(list(schedule_list.values()))

            for i in range(len(result)):
                product_ids=result[i][0]['prod_id']
                product_id=Product.objects.get(prod_id=product_ids)
                order_id=OrderList.objects.filter(prod_id=product_ids)
                comma_list = []
                for j in order_id.values():
                    comma_list.append(j['order_id'])

                prod_name=product_id.prod_name
                result[i][0]['prod_id'] = prod_name
                result[i][0]['order_id_num'] = comma_str(comma_list)

    return result

# 처리 확정 히스토리 표출
def schedule_history(request):
    result = fixed_list(request, request.user.groups.values('id')[0]['id'])

    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    # print(json.dumps(schedule_list, default=json_default))
    return HttpResponse(json.dumps(result, default=json_default))

# 처리 확정 히스토리 리스트 추출
def fixed_list(request, user_group):

    if user_group is None:
        user_group = request.user.groups.values('id')[0]['id'];
    date = datetime.datetime.today().strftime("%Y%m%d")

    print('user_group : ', user_group)

    use_yn_list = OrderSchedule.objects.raw(
        ' SELECT * FROM order_orderschedule ' +
        ' WHERE SUBSTRING(sch_id, 4, 8) = ' + date +
        ' GROUP BY use_yn'
    )
    if len(use_yn_list)%2 == 1:
        available_list = OrderSchedule.objects.raw(
            ' SELECT * FROM order_orderschedule WHERE SUBSTRING(sch_id, 4, 8) = ' + date +
            ' GROUP BY sch_id ')
    else:
        available_list = OrderSchedule.objects.raw(
            ' SELECT * FROM order_orderschedule WHERE SUBSTRING(sch_id, 4, 8) = ' + date +
            ' AND use_yn = "Y" ' +
            ' GROUP BY sch_id ')
        
    result = []
    for p in available_list:
        avail_dict = {}
        avail_dict['use_yn'] = p.use_yn
        avail_dict['schedule'] = list(
            Schedule.objects.filter(comp_id=user_group, sch_id=p.sch_id.sch_id).values())

        if len(avail_dict['schedule']) == 0:
            continue;
        else:
            result.append(avail_dict)

    return result

# 처리 가능 오더 확정
def fixed_order(request):
    user_group = request.user.groups.values('id')[0]['id'];
    if request.method == 'POST':
        request = json.loads(request.body)

    if request['type'] == 'customer':
        comp_name = request['comp_name']    # 회사명
        order_id = request['order_id']  # 오더 아이디
        order_ids = OrderSchedule.objects.filter(order_id=order_id)
        for j in order_ids:
            OrderSchedule.objects.update_or_create(
                order_id=j.order_id,
                sch_id=j.sch_id,
                use_yn='Y'
            )
    else:
        orders = request['order_list']
        if len(fixed_list(request, user_group)) > 0:
            result = fixed_list(request, user_group)
            for sch in result:
                OrderSchedule.objects.filter(sch_id=sch).update(use_yn='N')

        # 오더 아이디로 넘어옴
        for ord in orders:
            orders = Schedule.objects.filter(sch_id=ord)  # order_id 나중에 order_list 에서 조회해 오기
            if not orders: # 최초 수락일 때,
                # OrderSchedule.objects.filter(sch_id=ord).update(use_yn='Y')
                OrderSchedule.objects.filter(sch_id=ord).update(use_yn='N')
            else: # 최초 수락이 아닐 때,
                for i in orders:
                    order_ids = OrderList.objects.filter(prod_id=i.prod_id)
                    for j in order_ids:
                        OrderSchedule.objects.update_or_create(
                            order_id=OrderList.objects.get(order_id=j.order_id),
                            sch_id=Schedule.objects.get(sch_id=i.sch_id),
                            # use_yn='Y'
                            use_yn='N'
                        )

    return JsonResponse({"message": 'success'})

# 수락한 오더 리스트 조회
def confirmed_order(request):
    result = available_list(request)
    final_result = []
    confirmed_list = []
    use_yn_list = []

    for i in range(len(result)):
        try:
            sch_id = result[i]['sch_id']
            confirmed = OrderSchedule.objects.filter(sch_id=sch_id).filter(use_yn=result[i]['use_yn']).values()
            confirmed_list.append(confirmed)
            for j in confirmed:
                use_yn_list.append(j['use_yn'])
        except:
            sch_id = result[i][0]['sch_id']
            confirmed = OrderSchedule.objects.filter(sch_id=sch_id).values()
            if len(confirmed) == 0:
                confirmed_list.append(result[i])
            else:
                confirmed_list.append(confirmed)
            for j in confirmed:
                use_yn_list.append(j['use_yn'])

    use_yn_list = set(use_yn_list)
    use_yn_list = list(use_yn_list)

    if len(use_yn_list) > 1:
        for i in confirmed_list:
            if i[0]['use_yn'] == 'Y':
                final_result.append(list(i))
    else:
        for i in confirmed_list:

            final_result.append(list(i))

    def json_default(value):
        if isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%d')
        raise TypeError('not JSON serializable')

    # print(json.dumps(schedule_list, default=json_default))
    return HttpResponse(json.dumps(final_result, default=json_default))

# 스케줄 새로 생성시 삭제
def delete_order(request):
    # orders = request.POST.getlist('order_list[]')
    schs = request.POST.getlist('sch_list[]')
    # 오더 아이디로 넘어옴
    for sch in schs:
        OrderSchedule.objects.filter(sch_id=sch).update(use_yn = 'N')

        # OrderSchedule.objects.update_or_create(
            # use_yn='N',
        # )
        # OrderSchedule.objects.filter(order_id=ord.split('.')[0]).delete()  # order_id 나중에 order_list 에서 조회해 오기

    return JsonResponse({"message": 'success'})


def test_data(request):
    generate_data(request)

    # print(json.dumps(schedule_list, default=json_default))
    # return HttpResponse(json.dumps(list(final_result.values()), default=json_default))
    return JsonResponse({"message": 'success'})
