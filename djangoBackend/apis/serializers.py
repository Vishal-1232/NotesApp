from rest_framework import serializers

from apis.models import Notes


class NotesSerializer(serializers.HyperlinkedModelSerializer):
    id = serializers.ReadOnlyField()
    class Meta:
        model = Notes
        fields = '__all__'
