from django.db import models


# Create your models here.
class Information(models.Model):
    comp_id = models.IntegerField(primary_key=True)  # 작업호기
    comp_name = models.CharField(max_length=150, null=False)  # 제품명
    credibility = models.FloatField(null=True)  # 신뢰도
    address = models.CharField(max_length=200, null=False)  # 회사 위치
    contact = models.CharField(max_length=50, null=False)  # 연락처
    email = models.CharField(max_length=100, null=False)  # 이메일
    class Meta:
        verbose_name_plural = '회사정보등록'

    def __str__(self):
        return f'{self.comp_id} / {self.comp_name}'

class Facility(models.Model):
    facility_id = models.CharField(max_length=50, primary_key=True)  # 설비 아이디
    facility_name = models.IntegerField(null=False)  # 설비명
    comp_id = models.ForeignKey("Information", related_name="facilitycompany", on_delete=models.CASCADE, db_column="comp_id") # 회사아이디
    created_at = models.DateTimeField(auto_now_add=True)  # 생성일자
    modified_at = models.DateTimeField(auto_now=True)  # 수정일자

class Schedule(models.Model):
    sch_id = models.CharField(max_length=50, primary_key=True)
    comp_id = models.ForeignKey("Information", related_name="company_id", on_delete=models.CASCADE, db_column="comp_id")
    count = models.IntegerField(null=False)
    prod_id = models.CharField(max_length=120)
    order_id_num = models.CharField(max_length=120)
    facility_id = models.ForeignKey("Facility", related_name="facilityId", on_delete=models.CASCADE, db_column="facility_id")  # 회사아이디
    created_at = models.DateTimeField(auto_now_add=True)  # 생성일자
    sch_color = models.CharField(max_length=50, null=False)
    x_axis_1 = models.FloatField(null=False)
    x_axis_2 = models.FloatField(null=False)
    y_axis_1 = models.FloatField(null=False)
    work_str_date = models.CharField(max_length=12, null=False)
    work_end_date = models.CharField(max_length=12, null=False)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)

class Product(models.Model):
    idx = models.AutoField(primary_key=True)
    prod_id = models.CharField(max_length=120)
    comp_id = models.ForeignKey("Information", related_name="company", on_delete=models.CASCADE, db_column="comp_id")
    prod_name = models.CharField(max_length=120)
    density = models.FloatField(null=False) # 밀도
    rpm = models.FloatField(null=False)
    daily_prod_rate = models.FloatField(null=False)
    cost = models.FloatField(null=True)
    image = models.ImageField(upload_to='images/', blank=True, null=True)
    recommend_yn = models.CharField(max_length=2)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
