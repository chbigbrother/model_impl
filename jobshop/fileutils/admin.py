from django.contrib import admin

from .models import FileUpload, Photo

class PhotoInline(admin.TabularInline):
    model = Photo

class FileUploadAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'author', 'content', 'created_at')
    list_display_links = ('id', 'title')
    search_fields = ('title', 'author', 'content')
    readonly_fields = ['created_at']
    list_filter = ('author', 'created_at', 'created_at')
    inlines = [PhotoInline, ]

admin.site.register(FileUpload, FileUploadAdmin)

