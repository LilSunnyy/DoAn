# Generated by Django 4.2.8 on 2024-03-18 09:26

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('soundcloud', '0002_tracks_like'),
    ]

    operations = [
        migrations.AddField(
            model_name='playlisttracks',
            name='created_date',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='playlisttracks',
            name='is_active',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='playlisttracks',
            name='updated_date',
            field=models.DateTimeField(auto_now=True),
        ),
    ]
