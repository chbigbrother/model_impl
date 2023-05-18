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
from company.models import Schedule, Information, Product, Facility
from common.views import id_generate, date_str, date_remove, money_count
from company.models import *
from datetime import timedelta
import datetime, json, csv, math
import pandas as pd
from urllib.parse import quote

# 소재 추천 목록 recommend list HTML
def home(request):
    template_name = 'recommend/recommend_list.html'
    recommends = recommend_list(request)
    context = {
        'path': '소재추천 / 추천소재검색',
        'recommends': recommends,
        'selected': 'recommendlist'
    }
    return render(request, template_name, context)

def recommend_list(request):
    recomm_select = Product.objects.filter(recommend_yn='Y')
    recomm_list = []
    for i in recomm_select:
        result_dict = {}
        result_dict['prod_id'] = i.prod_id
        result_dict['comp_id'] = i.comp_id_id
        result_dict['comp_name'] = i.comp_id.comp_name
        result_dict['prod_name'] = i.prod_name
        result_dict['density'] = i.density
        result_dict['rpm'] = i.rpm
        result_dict['daily_prod_rate'] = i.daily_prod_rate
        result_dict['cost'] = i.cost
        result_dict['image'] = i.image
        recomm_list.append(result_dict)

    return recomm_list
