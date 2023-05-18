from django.db import models


class Article(models.Model):
    title = models.CharField(max_length=120, null=False)
    author = models.CharField(max_length=20, null=False)
    content = models.TextField(null=False)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    class Meta:
        verbose_name_plural = '게시판' 

    def __str__(self):
        return f'{self.id} / {self.title} / {self.author}'