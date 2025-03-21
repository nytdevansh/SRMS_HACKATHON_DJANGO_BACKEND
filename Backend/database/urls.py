from os import name
from django.urls import URLPattern, path
from . import views

urlpatterns = [
    path('', views.get_location_data, name='get_location_data'),  # Root URL
    path('get_location_data/', views.get_location_data, name='get_location_data_alt'),  # Keep the old URL too
    
]
