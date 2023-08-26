from django.shortcuts import render
from rest_framework import viewsets

from apis.models import Notes
from apis.serializers import NotesSerializer


# Create your views here.
class NotesViewSet(viewsets.ModelViewSet):
    queryset = Notes.objects.all()
    serializer_class = NotesSerializer
