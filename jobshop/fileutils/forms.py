from django import forms
from .models import FileUploadCsv

class FileUploadCsv(forms.ModelForm):
    class Meta:
        model = FileUploadCsv
        fields = ('title', 'file')
