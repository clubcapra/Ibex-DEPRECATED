__author__ = 'jstcyr'

class Coordinates:
    def __init__(self, id, lat, long):
        self.id = id

        if float(lat) > 90 or float(lat) < -90:
            raise ValueError("Latitude must be between -90 and 90.")

        if float(long) > 180 or float(long) < -180:
            raise ValueError("Longitude must be between -180 and 180.")

        self.lat = lat
        self.long = long

    def __str__(self):
        return str("id: " + self.id).ljust(15) + str(" lat: " + self.lat).ljust(20) + str(" long: " + self.long).ljust(20)