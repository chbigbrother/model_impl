# board/comp_admin.py

from django.contrib import admin

from .models import Article


class ArticleAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'author', 'content', 'created_at', 'modified_at')
    list_display_links = ('id', 'title', 'author')
    search_fields = ('title', 'author', 'content')
    readonly_fields = ('created_at', 'modified_at')
    list_filter = ('author', 'created_at', 'modified_at')
    # list_editable = ('title', 'author')
    # ordering = ('author', '-modified_at')
    # list_per_page = 30


admin.site.register(Article, ArticleAdmin)