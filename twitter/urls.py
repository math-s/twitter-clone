from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from rest_framework_jwt.views import obtain_jwt_token, refresh_jwt_token
from core import views

router = routers.DefaultRouter()
router.register(r'post',views.PostViewSet, basename='Post')
router.register(r'user',views.UserViewSet, basename='User')

urlpatterns = [
    path('api/', include(router.urls)),
    path('admin/', admin.site.urls),
    path('api/auth/login/', obtain_jwt_token, name='login'),
    path('api/auth/login/refresh/', refresh_jwt_token),
]
