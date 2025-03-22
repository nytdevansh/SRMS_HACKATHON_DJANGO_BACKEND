from django.db import models

# Create your models here.




class Locations(models.Model):
    name = models.CharField(max_length=255)
    latitude = models.FloatField()
    longitude = models.FloatField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def clean(self):
        from django.core.exceptions import ValidationError
        if not (-90 <= self.latitude <= 90):
            raise ValidationError('Latitude must be between -90 and 90.')
        if not (-180 <= self.longitude <= 180):
            raise ValidationError('Longitude must be between -180 and 180.')

    def __str__(self):
        return self.name
