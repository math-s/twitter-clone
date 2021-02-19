from django.db import models
from django.contrib.auth.models import User


class Person(User):
    class Meta:
        proxy = True
    
    
class Post(models.Model):
    content = models.TextField(max_length=140)
    created_at = models.DateTimeField(auto_now=True)
    person = models.ForeignKey('Person', on_delete=models.CASCADE)