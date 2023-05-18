# jobshopscheduling
## 프로젝트 만들기

파이참 Terminal 에서 cd 명령으로 코드 실행 디렉토리로 이동 후, 다음의 명령을 수행 <br/>

<code> $ django-admin startproject jobshop </code>

jobshop 디렉토리 내부 django 셋팅 파일 생성 확인 <br/>

## 데이터베이스 설치

<code>$ pip install pymysql</code>
<code>$ python manage.py migrate</code>

## 모델의 활성화 및 데이터 베이스 적용

<code>$ python manage.py makemigrations</code> <br/>
<code>$ python manage.py migrate</code>

## Django 서버 실행

파이참 Terminal 에서 cd 명령으로 코드 실행 디렉토리로 이동 후, 다음의 명령을 수행 <br/>

<code>$ python manage.py runserver 0.0.0.0:8000</code>
