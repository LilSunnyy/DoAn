from rest_framework import viewsets, permissions, generics,status
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser

from .forms import UserRegisterForm, AdminRegisterForm, UserUpdateForm
from .models import *
from rest_framework.decorators import action
from .serializers import *
from django.shortcuts import get_object_or_404
from django.http import HttpResponse
import json
from oauth2_provider.models import get_access_token_model, get_application_model
from oauth2_provider.signals import app_authorized
from oauth2_provider.views.base import TokenView
from django.utils.decorators import method_decorator
from django.views.decorators.debug import sensitive_post_parameters
# from dj_rest_auth.registration.views import SocialLoginView
from allauth.socialaccount.providers.github.views import GitHubOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client

class UserPagination(PageNumberPagination):
    page_size = 5

# class CustomTokenView(TokenView):
#     @method_decorator(sensitive_post_parameters("password"))
#     def post(self, request, *args, **kwargs):
#         url, headers, body, status = self.create_token_response(request)
#         if status == 200:
#             body = json.loads(body)
#             access_token = body.get("access_token")
#             if access_token is not None:
#                 token = get_access_token_model().objects.get(
#                     token=access_token)
#                 app_authorized.send(
#                     sender=self, request=request,
#                     token=token)
#                 body['user'] = {
#                     'id': token.user.id,
#                     'username': token.user.username,
#                     'email': token.user.email,
#                     'avatar': token.user.avatar.name
#                 }
#                 body = json.dumps(body)
#         response = HttpResponse(content=body, status=status)
#         for k, v in headers.items():
#             response[k] = v
#         return response
#
# class GithubLogin(SocialLoginView):
#     adapter_class = GitHubOAuth2Adapter
#     callback_url = "http://127.0.0.1:3000/"
#     client_class = OAuth2Client

class UserViewSet(viewsets.ViewSet,
                  generics.ListAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, FormParser]
    pagination_class = UserPagination

    def get_permissions(self):
        if self.action == 'list' or self.action == 'hide_user':
            return [permissions.IsAdminUser()]
        return [permissions.IsAuthenticated()]

    @action(methods=['get'], detail=False, url_path='current-user')
    def current_user(self, request):
        return Response(self.serializer_class(request.user, context={"request": request}).data,
                        status=status.HTTP_200_OK)

    @action(methods=['patch'], detail=False, url_path='update-user')
    def update_user(self, request):
        user_id = request.data.get('id')
        if not id:
            return Response({'message': 'Không có ID user.'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_object_or_404(User, id=user_id)

        form = UserUpdateForm(instance=user, data=request.data)
        if form.is_valid():
            form.save()
            return Response({'message': 'Sửa thành công.'}, status=status.HTTP_200_OK)
        return Response(form.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='register')
    def register_user(self, request):
        if request.user.is_superuser:
            form = AdminRegisterForm(data=request.POST)
        else:
            form = UserRegisterForm(data=request.POST)

        if request.method == 'POST':
            if form.is_valid():
                form.save()
                return Response(status=status.HTTP_201_CREATED)
            else:
                errors = dict(form.errors)
                return Response({'errors': errors}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'error': 'Invalid request method'}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['patch'], detail=False, url_path='change-password')
    def change_password(self, request):
        user = request.user
        data = request.data

        old_password = data.get('old_password')
        new_password = data.get('new_password')

        if not user.check_password(old_password):
            return Response({'message': 'Mật khẩu cũ không đúng'}, status=status.HTTP_400_BAD_REQUEST)

        user.set_password(new_password)
        user.save()

        return Response({'message': 'Mật khẩu đã được thay đổi'}, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True,
            url_path="hide-user",
            url_name="hide-user")
    def hide_user(self, request, pk):
        try:
            u = User.objects.get(pk=pk)
            u.is_active = not u.is_active
            u.save()
        except User.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        return Response(data=UserSerializer(u, context={'request': request}).data, status=status.HTTP_200_OK)


class TracksViewSet(viewsets.ViewSet,
                  generics.RetrieveAPIView,
                    generics.ListAPIView,
                    generics.CreateAPIView):
    queryset = Tracks.objects.filter(is_active = True)
    serializer_class = TracksSerializer

    def retrieve(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            serializer = self.get_serializer(instance)
            response_data = {
                'error': None,
                'message': 'Success',
                'statusCode': status.HTTP_200_OK,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_200_OK)
        except Tracks.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy bài nhạc.',
                'message': 'Không tìm thấy bài nhạc.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-tracks",
            url_name="hide-tracks")
    def hide_course(self, request, pk):
        try:
            t = Tracks.objects.get(pk=pk)
            t.is_active = False
            t.save()
        except Tracks.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Tracks(t, context={'request': request}).data, status=status.HTTP_200_OK)

class GenreViewSet(viewsets.ViewSet,
                  generics.RetrieveAPIView,
                    generics.ListAPIView):
    queryset = Genre.objects.filter(is_active = True)
    serializer_class = GenreSerializer

    def retrieve(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            serializer = self.get_serializer(instance)
            response_data = {
                'error': None,
                'message': 'Success',
                'statusCode': status.HTTP_200_OK,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_200_OK)
        except Genre.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy thể loại.',
                'message': 'Không tìm thấy thể loại.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-genre",
            url_name="hide-genre")
    def hide_course(self, request, pk):
        try:
            g = Genre.objects.get(pk=pk)
            g.is_active = False
            g.save()
        except Genre.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Tracks(g, context={'request': request}).data, status=status.HTTP_200_OK)