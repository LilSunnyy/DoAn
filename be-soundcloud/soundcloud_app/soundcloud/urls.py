from django.contrib import admin
from django.urls import path, re_path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter
from django.conf.urls.static import static
from django.conf import settings

router = DefaultRouter()
router.register('tracks', views.TracksViewSet)
router.register('user', views.UserViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin_site.urls),
]
