from django.test import TestCase
from django.urls import reverse

class LocationDataTests(TestCase):
    def test_get_location_data(self):
        response = self.client.get(reverse('get_location_data'), {'query': 'New York'})
        self.assertEqual(response.status_code, 200)
        self.assertIn('message', response.json())
