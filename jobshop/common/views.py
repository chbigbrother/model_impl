from django.shortcuts import render
from datetime import datetime
import re

# Create your views here.
def id_generate(request, id):

    if id is None or not id:
        id = 0
    else:
        int_id = id

    int_id = int(id) + 1
    str_id = request

    if int_id < 10:
        str_id = request + '00' + str(int_id)
    if int_id >= 10:
        str_id = request + '0' + str(int_id)
    if int_id > 99:
        str_id = request + str(int_id)

    return str_id

def comma_str(data):
    commas = ''
    for i in range(len(data)):
        if len(data) == 1:
            commas += data[i]
        else:
            if i == len(data)-1:
                commas += data[i]
            else:
                commas += data[i] + ', '

    return commas

def date_str(date):
    str_date = date[0:4] + '-' + date[4:6] + '-' + date[6:8]

    return str_date

def date_remove(date):
    str_date = date.replace('-', '').replace('-', '')

    return str_date

def calc_date_str(datefrom, dateto):
    date_from = datetime.strptime(datefrom, "%Y%m%d")
    date_to = datetime.strptime(dateto, "%Y%m%d")
    date_diff = date_to - date_from

    return date_diff

def money_count(data):
    data = str(int(data))
    cost = ''
    count = 0
    for i in range(len(data)):
        count += 1;
        cost += data[i]
        if count % 3 == 2 and i is not len(data) - 1:
            cost += ','
    return cost

def regex(data):
    str = re.sub(r"[^a-zA-Z0-9]", "", data);

    return str