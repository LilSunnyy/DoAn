import mimetypes

from rest_framework import viewsets, permissions, generics,status
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser, DataAndFiles, JSONParser

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
from dj_rest_auth.registration.views import SocialLoginView
from allauth.socialaccount.providers.github.views import GitHubOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from rest_framework.decorators import api_view
import time
from rest_framework.exceptions import ValidationError

class Pagination(PageNumberPagination):
    page_size = 5

class CustomTokenView(TokenView):
    @method_decorator(sensitive_post_parameters("password"))
    def post(self, request, *args, **kwargs):
        url, headers, body, status = self.create_token_response(request)
        if status == 200:
            body = json.loads(body)
            access_token = body.get("access_token")
            if access_token is not None:
                token = get_access_token_model().objects.get(
                    token=access_token)
                app_authorized.send(
                    sender=self, request=request,
                    token=token)
                body['user'] = {
                    'id': token.user.id,
                    'username': token.user.username,
                    'email': token.user.email,
                    'avatar': token.user.avatar.name
                }
                body = json.dumps(body)
        response = HttpResponse(content=body, status=status)
        for k, v in headers.items():
            response[k] = v
        return response

class GithubLogin(SocialLoginView):
    adapter_class = GitHubOAuth2Adapter
    callback_url = "http://127.0.0.1:3000/"
    client_class = OAuth2Client

class UserViewSet(viewsets.ViewSet,
                  generics.ListAPIView):
    queryset = User.objects.filter(is_active=True).order_by('-date_joined')
    serializer_class = UserSerializer
    pagination_class = Pagination

    def get_permissions(self):
        if self.action == 'list' or self.action == 'hide_user' or self.action == 'register_user' \
                or self.action == 'update_user':
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
                response_data = {
                    'error': None,
                    'message': 'Tạo người dùng thành công',
                    'statusCode': status.HTTP_200_OK,
                }
                return Response(data=response_data, status=status.HTTP_200_OK)
            else:
                errors = dict(form.errors)
                response_data = {
                    'error': errors,
                    'message': 'Lỗi khi tạo người dùng',
                    'statusCode': status.HTTP_400_BAD_REQUEST,
                }
                return Response(response_data, status=status.HTTP_400_BAD_REQUEST)
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
    queryset = Tracks.objects.filter(is_active=True).order_by('-created_date')
    serializer_class = TracksSerializer
    pagination_class = Pagination
    parser_classes = (MultiPartParser, FormParser, JSONParser)
    lookup_field = 'id'

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.IsAuthenticated()]
        else:
            return [permissions.AllowAny()]

    @action(detail=False, methods=['post'], url_path='user')
    def get_user_tracks(self, request):
        user_id = request.data.get('user_id')
        if not user_id:
            return Response({'error': 'Thiếu thông tin user_id'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            response_data = {
                'error': 'Người dùng không tồn tại',
                'message': 'Người dùng không tồn tại',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data= response_data, status=status.HTTP_400_BAD_REQUEST)

        tracks = Tracks.objects.filter(fk_user=user)

        serializer = TracksSerializer(tracks, many=True, context={'request': request})
        response_data = {
            'error': None,
            'message': 'Lấy danh sách track của người dùng thành công',
            'statusCode': status.HTTP_200_OK,
            'results': serializer.data,
        }
        return Response(data=response_data, status=status.HTTP_200_OK)

    def create(self, request, *args, **kwargs):
        # Xác định user từ request
        user = request.user
        serializer_class = self.get_serializer_class()

        # Kiểm tra xem header 'target-type' có trong request không
        if 'target-type' in self.request.headers and self.request.headers['target-type'] == 'audio':
            serializer = serializer_class(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(fk_user=user)
            response_data = {
                'error': None,
                'message': 'Track Audio is uploaded successfully',
                'statusCode': status.HTTP_201_CREATED,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_201_CREATED)
        else:
            try:
                # Trích xuất id từ dữ liệu gửi lên từ client
                track_id = request.data.get('id')
                genre_id = request.data.get('fk_genre')

                # Kiểm tra xem genre_id có tồn tại không
                if not genre_id and 'target-type' not in self.request.headers:
                    response_data = {
                        'error': 'ID của thể loại chưa được cung cấp',
                        'message': 'No genre ID provided',
                        'statusCode': status.HTTP_400_BAD_REQUEST,
                        'results': None,
                    }
                    return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

                # Kiểm tra xem track_id có tồn tại không
                if not track_id:
                    response_data = {
                        'error': 'No track ID provided',
                        'message': 'No track ID provided',
                        'statusCode': status.HTTP_400_BAD_REQUEST,
                        'results': None,
                    }
                    return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

                # Tạo serializer mới với instance là track với id đã trích xuất
                track_instance = self.get_queryset().get(id=track_id)
                track_instance.fk_genre_id = genre_id
                serializer = serializer_class(track_instance, data=request.data, partial=True)

                # Validate và lưu thông tin còn lại của track
                serializer.is_valid(raise_exception=True)
                serializer.save()

                response_data = {
                    'error': None,
                    'message': 'Track is created successfully',
                    'statusCode': status.HTTP_201_CREATED,
                    'results': serializer.data,
                }
                return Response(data=response_data, status=status.HTTP_201_CREATED)
            except ValidationError as e:
                response_data = {
                    'error': str(e),
                    'message': 'Error creating track',
                    'statusCode': status.HTTP_400_BAD_REQUEST,
                    'results': None,
                }
                return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

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
    def hide_tracks(self, request, id):
        try:
            t = Tracks.objects.get(pk=id)
            t.is_active = False
            t.save()
        except Tracks.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Tracks(t, context={'request': request}).data, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=False, url_path='top',url_name="top")
    def top_tracks(self, request):
        name = request.data.get('genre')
        if name is not None:
            try:
                genre = Genre.objects.get(name=name)
                # Tìm kiếm và sắp xếp các bài hát theo số lượt thích trong thể loại được chỉ định.
                tracks = Tracks.objects.filter(fk_genre=genre, is_active=True).order_by('-view')
                serializer = TracksSerializer(tracks, many=True, context={'request': request})
                response_data = {
                    'error': None,
                    'message': 'Tìm thành công',
                    'statusCode': status.HTTP_200_OK,
                    'results': serializer.data,
                }
                return Response(data=response_data, status=status.HTTP_200_OK)
            except Genre.DoesNotExist:
                response_data = {
                    'error': serializer.errors,
                    'message': 'Thể loại không tồn tại',
                    'statusCode': status.HTTP_400_BAD_REQUEST,
                    'results': None,
                }
                return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)
        response_data = {
            'error': 'Lỗi không tìm thấy tên thể loại',
            'message': 'Lỗi không tìm thấy tên thể loại',
            'statusCode': status.HTTP_400_BAD_REQUEST,
            'results': None,
        }
        return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=True, methods=['get'], url_path='audio')
    def get_audio_url(self, request, id=None):
        try:
            track = self.get_object()
            audio_file = track.url.path
            with open(audio_file, 'rb') as file:
                audio_data = file.read()
            content_type, _ = mimetypes.guess_type(audio_file)
            response = HttpResponse(audio_data, content_type=content_type)
            return response
        except Tracks.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy bài nhạc.',
                'message': 'Không tìm thấy bài nhạc.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'audio_url': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

class GenreViewSet(viewsets.ViewSet,
                  generics.RetrieveAPIView,
                    generics.ListAPIView):
    queryset = Genre.objects.filter(is_active = True).order_by('id')
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
    def hide_genre(self, request, pk):
        try:
            g = Genre.objects.get(pk=pk)
            g.is_active = False
            g.save()
        except Genre.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Genre(g, context={'request': request}).data, status=status.HTTP_200_OK)

class PlaylistViewSet(
                    viewsets.ViewSet,
                    generics.RetrieveAPIView,
                    generics.ListAPIView):
    queryset = Playlist.objects.filter(is_active = True)
    serializer_class = PlaylistSerializer
    pagination_class = Pagination

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
        except Playlist.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy.',
                'message': 'Không tìm thấy.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-playlist",
            url_name="hide-playlist")
    def hide_playlist(self, request, pk):
        try:
            p = Playlist.objects.get(pk=pk)
            p.is_active = False
            p.save()
        except Genre.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Playlist(p, context={'request': request}).data, status=status.HTTP_200_OK)

class PlaylistTracksViewSet(
                    viewsets.ViewSet,
                    generics.RetrieveAPIView,
                    generics.ListAPIView):
    queryset = PlaylistTracks.objects.filter(is_active = True)
    serializer_class = PlaylistTracksSerializer
    pagination_class = Pagination

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
        except PlaylistTracks.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy.',
                'message': 'Không tìm thấy.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-playlisttracks",
            url_name="hide-playlisttracks")
    def hide_playlisttracks(self, request, pk):
        try:
            p = PlaylistTracks.objects.get(pk=pk)
            p.is_active = False
            p.save()
        except PlaylistTracks.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=PlaylistTracks(p, context={'request': request}).data, status=status.HTTP_200_OK)

class CommentViewSet(
                    viewsets.ViewSet,
                    generics.RetrieveAPIView,
                    generics.ListAPIView,
                    generics.CreateAPIView):
    queryset = Comment.objects.filter(is_active = True).order_by('-created_date')
    serializer_class = CommentSerializer
    pagination_class = Pagination

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.IsAuthenticated()]
        else:
            return [permissions.AllowAny()]

    def create(self, request, *args, **kwargs):
        try:
            user = request.user

            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(fk_user=user)

            response_data = {
                'error': None,
                'message': 'Comment created successfully',
                'statusCode': status.HTTP_201_CREATED,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_201_CREATED)
        except Exception as e:
            response_data = {
                'error': str(e),
                'message': 'Error creating comment',
                'statusCode': status.HTTP_400_BAD_REQUEST,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

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
        except Comment.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy.',
                'message': 'Không tìm thấy.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['get'], detail=True, url_path='track-comments')
    def get_comments(self, request, pk):
        try:
            track = Tracks.objects.get(pk=pk)
            comments = Comment.objects.filter(fk_tracks=track)
            serializer = CommentSerializer(comments, many=True)
            response_data = {
                'error': None,
                'message': 'Thành công',
                'statusCode': status.HTTP_200_OK,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_200_OK)
        except Tracks.DoesNotExist:
            response_data = {
                'error': 'Bài hát không tồn tại',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': serializer.data,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-comment",
            url_name="hide-comment")
    def hide_comment(self, request, pk):
        try:
            c = Comment.objects.get(pk=pk)
            c.is_active = False
            c.save()
        except Comment.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Comment(c, context={'request': request}).data, status=status.HTTP_200_OK)

class LikeViewSet(
                    viewsets.ViewSet,
                    generics.RetrieveAPIView,
                    generics.ListAPIView,
                    generics.CreateAPIView):
    queryset = Like.objects.filter(is_active = True)
    serializer_class = CommentSerializer
    pagination_class = Pagination
    def get_permissions(self):
        if self.action == 'create'or self.action == 'retrieve':
            return [permissions.IsAuthenticated()]
        else:
            return [permissions.AllowAny()]

    def create(self, request, *args, **kwargs):
        try:
            user = request.user
            track_id = request.data.get('fk_tracks')
            like_value = request.data.get('like', False)

            if not track_id:
                raise ValueError("No track ID provided.")

            track = Tracks.objects.get(id=track_id)

            # Kiểm tra xem người dùng đã thích bài hát này chưa
            already_liked = Like.objects.filter(fk_user=user, fk_tracks=track).exists()

            # Nếu người dùng đã thích, cập nhật lại giá trị like của bài hát
            if already_liked:
                if like_value:  # Nếu giá trị like gửi lên là True
                    track.like += 1  # Tăng giá trị like
                else:
                    track.like -= 1  # Giảm giá trị like
                track.save()  # Lưu lại thay đổi

            # Lưu thông tin về like mới
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(fk_user=user)
            trackAfterSave = Tracks.objects.get(id=track_id)
            serializerResponse = TracksSerializer(trackAfterSave)

            response_data = {
                'error': None,
                'message': 'Liked successfully',
                'statusCode': status.HTTP_201_CREATED,
                'results': serializerResponse.data,
            }
            return Response(data=response_data, status=status.HTTP_201_CREATED)
        except Exception as e:
            response_data = {
                'error': str(e),
                'message': 'Like error',
                'statusCode': status.HTTP_400_BAD_REQUEST,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_400_BAD_REQUEST)

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
        except Like.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy.',
                'message': 'Không tìm thấy.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-like",
            url_name="hide-like")
    def hide_comment(self, request, pk):
        try:
            l = Like.objects.get(pk=pk)
            l.is_active = False
            l.save()
        except Like.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Like(l, context={'request': request}).data, status=status.HTTP_200_OK)

class FollowerViewSet(
                    viewsets.ViewSet,
                    generics.RetrieveAPIView,
                    generics.ListAPIView):
    queryset = Follower.objects.filter(is_active = True)
    serializer_class = FollowerSerializer
    pagination_class = Pagination

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
        except Follower.DoesNotExist:
            response_data = {
                'error': 'Không tìm thấy.',
                'message': 'Không tìm thấy.',
                'statusCode': status.HTTP_404_NOT_FOUND,
                'results': None,
            }
            return Response(data=response_data, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True,
            url_path="hide-follower",
            url_name="hide-follower")
    def hide_comment(self, request, pk):
        try:
            f = Follower.objects.get(pk=pk)
            f.is_active = False
            f.save()
        except Follower.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=Follower(f, context={'request': request}).data, status=status.HTTP_200_OK)