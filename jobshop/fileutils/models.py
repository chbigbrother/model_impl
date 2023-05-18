from django.db import models
from django.conf import settings
from django.core.files.storage import FileSystemStorage
from uuid import uuid4
import os

class FileUpload(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=120, null=False)
    author = models.CharField(max_length=20, null=False)
    file = models.FileField(upload_to='')
    content = models.TextField(max_length=500, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    class Meta:
        verbose_name_plural = '파일 게시판'

class Photo(models.Model):
    post = models.ForeignKey(FileUpload, on_delete=models.CASCADE, null=True)
    image = models.ImageField(upload_to='images/', blank=True, null=True)

class OverwriteStorage(FileSystemStorage):
    '''
    file 같은 이름 존재할 경우 overwrite
    '''
    def get_available_name(self, name, max_length=None):
        if self.exists(name):
            os.remove(os.path.join(settings.MEDIA_ROOT, name))
        return name

def get_random_filename(instance, filename):
    filename = "%s" % (str(filename))
    return os.path.join(filename)


class FileUploadCsv(models.Model):
    title = models.TextField(max_length=500, null=True, blank=True)
    file = models.FileField(null=True, storage=OverwriteStorage(), upload_to=get_random_filename)
