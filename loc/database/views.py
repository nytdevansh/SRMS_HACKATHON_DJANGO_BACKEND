import requests
from django.http import JsonResponse
from .models import Locations

TOMTOM_API_KEY = '5c7OPcT95AodKEGXjWafwWLcXBgVzbzr'





def get_location_data(request):
    query = request.GET.get('query', 'New York')
    url = f'https://api.tomtom.com/search/2/search/{query}.json?key={TOMTOM_API_KEY}'
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        if 'results' in data and data['results']:
            result = data['results'][0]  # Take the first result
            position = result['position']
            name = result.get('poi', {}).get('name', query)
            latitude = position['lat']
            longitude = position['lon']

            # Check for existing location
            existing_location = Locations.objects.filter(name=name, latitude=latitude, longitude=longitude).first()
            if existing_location:
                return JsonResponse({
                    'message': 'Location retrieved successfully',
                    'location_id': existing_location.id,
                    'name': existing_location.name,
                    'latitude': existing_location.latitude,
                    'longitude': existing_location.longitude
                })
            else:
                # Store in the database
                location = Locations.objects.create(name=name, latitude=latitude, longitude=longitude)
                return JsonResponse({
                    'message': 'Location saved successfully',
                    'location_id': location.id,
                    'name': location.name,
                    'latitude': location.latitude,
                    'longitude': location.longitude
                })

    return JsonResponse({'error': 'Failed to fetch data from TomTom API'}, status=500)
