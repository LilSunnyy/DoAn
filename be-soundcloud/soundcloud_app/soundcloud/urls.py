from django.contrib import admin
from django.urls import path, re_path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter
from .views import GithubLogin

router = DefaultRouter()
router.register('tracks', views.TracksViewSet)
router.register('users', views.UserViewSet)
router.register('genre', views.GenreViewSet)
router.register('playlist', views.PlaylistViewSet)
router.register('playlisttracks', views.PlaylistTracksViewSet)
router.register('comment', views.CommentViewSet)
router.register('like', views.LikeViewSet)
router.register('follower', views.FollowerViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin_site.urls),
    path('o/', include('oauth2_provider.urls', namespace='oauth2_provider')),
    path('github/', GithubLogin.as_view(), name="github_login"),
]
