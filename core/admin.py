from django.contrib import admin
from .models import Person, Post

admin.site.register(Post)
admin.site.register(Person)