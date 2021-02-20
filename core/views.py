from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import viewsets
from django.contrib.auth.models import User
from django.contrib.auth import logout
from django.shortcuts import HttpResponseRedirect
from .serializers import UserSerializer, PostSerializer
from .models import Post, Person


class PostViewSet(viewsets.ModelViewSet):
    serializer_class = PostSerializer
    permission_classes = (IsAuthenticated,)
    
    def get_queryset(self):
        user = self.request.user
        return Post.objects.all().exclude(person=user).order_by('created_at')[:10]
    

class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (AllowAny,)
    queryset = Person.objects.all()
    serializer_class = UserSerializer