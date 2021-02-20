from rest_framework import serializers
from rest_framework.fields import CurrentUserDefault
from django.contrib.auth.models import User
from .models import Post, Person
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user


class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ('content', 'person')

    def create(self, validated_data):
        post = Post(**validated_data)
        person = self.context['request'].user
        content = self.validated_data['content']
        post.content = content
        post.person = person
        post.save()
        return post


