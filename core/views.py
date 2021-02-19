from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from .models import  Post, Person
from .serializers import UserSerializer, PostSerializer


class PostViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Person.objects.all()
    serializer_class = UserSerializer