from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from .models import *

class UserSerializer(ModelSerializer):
    avatar = serializers.SerializerMethodField(source='avatar')
    class Meta:
        model = User
        fields = '__all__'
        extra_kwargs = {
            'password' : {'write_only':'true'}
        }

    def validate(self, data):
        if 'password' not in data or 'username' not in data or data['password'] == '' or data['username'] == '':
            raise serializers.ValidationError("Mật khẩu không được để trống")

        email = data.get('email')
        if User.objects.filter(email=email).exists():
            raise serializers.ValidationError("Email đã tồn tại trong hệ thống")

        username = data.get('username')
        if User.objects.filter(username=username).exists():
            raise serializers.ValidationError("Tên người dùng đã tồn tại trong hệ thống")
        return data

    def get_avatar(self, user):
        if user.avatar:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri('/static/%s' % user.avatar.name)

            return '/static/%s' % user.avatar.name

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        return user

class GenreSerializer(ModelSerializer):
    class Meta:
        model = Genre
        fields = '__all__'

class TracksSerializer(ModelSerializer):
    fk_user = UserSerializer()
    fk_genre = GenreSerializer()
    class Meta:
        model = Tracks
        fields = '__all__'

    def to_representation(self, instance):
        representation = super().to_representation(instance)

        # Xóa domain từ URL hình ảnh
        if 'photo' and 'url' in representation and representation['photo']:
            representation['photo'] = representation['photo'].replace(self.context['request'].build_absolute_uri('/'),
                                                                      '')
            representation['url'] = representation['url'].replace(self.context['request'].build_absolute_uri('/'),
                                                                      '')
        return representation

class PlaylistSerializer(ModelSerializer):
    class Meta:
        model = Playlist
        fields = '__all__'

class PlaylistTracksSerializer(ModelSerializer):
    class Meta:
        model = PlaylistTracks
        fields = '__all__'

class CommentSerializer(ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

class LikeSerializer(ModelSerializer):
    class Meta:
        model = Like
        fields = '__all__'

class FollowerSerializer(ModelSerializer):
    class Meta:
        model = Follower
        fields = '__all__'