from django.urls import reverse_lazy
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView
from .models import Article

class ArticleList(ListView):
    model = Article
    paginate_by = 5
    ordering = ['id']

class ArticleCreate(CreateView):
    model = Article
    fields = ['title', 'author', 'content']
    success_url = reverse_lazy('index')


class ArticleDetail(DetailView):
    model = Article
    # context_object_name = 'article'


class ArticleUpdate(UpdateView):
    model = Article
    fields = ['title', 'author', 'content']
    success_url = reverse_lazy('index')


class ArticleDelete(DeleteView):
    model = Article
    success_url = reverse_lazy('index')