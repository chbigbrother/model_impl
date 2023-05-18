from django.db import models


# Create your models here.
class OrderList(models.Model):
    order_id = models.CharField(max_length=200, primary_key=True) # 오더 아이디
    cust_name = models.CharField(max_length=50, null=False)  # 고객 아이디
    sch_date = models.CharField(max_length=12, null=False) # 오더 일자
    exp_date = models.CharField(max_length=12, null=False) # 작업완료기한
    prod_id = models.CharField(max_length=120)
    # prod_id = models.ForeignKey("company.Product", on_delete=models.CASCADE, db_column="prod_id")
    amount = models.FloatField(null=False) # 오더 수량
    contact = models.CharField(max_length=120)  # 연락처
    email = models.CharField(max_length=120)  # 이메일
    order_status = models.FloatField(null=False) # 주문 상태
    created_at = models.DateTimeField(auto_now_add=True) # 생성일자
    modified_at = models.DateTimeField(auto_now=True) # 수정일자

class OrderSchedule(models.Model):
    idx = models.AutoField(primary_key=True)  # 번호
    sch_id = models.ForeignKey("company.Schedule", on_delete=models.CASCADE, db_column="sch_id")
    order_id = models.ForeignKey("OrderList", related_name="orderlist", on_delete=models.CASCADE, db_column="order_id")
    use_yn = models.CharField(max_length=1)  # 확정 여부
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)