

from math import radians, cos, sin, asin, sqrt
import re
def haversine(lon1, lat1, lon2, lat2):
    """
    Calculate the great circle distance between two points
    on the earth (specified in decimal degrees)
    """
    # convert decimal degrees to radians
    lon1, lat1, lon2, lat2 = map(radians, [lon1, lat1, lon2, lat2])
    # haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
    c = 2 * asin(sqrt(a))
    m = 6378.1 * 1000 * c # radius of earth in kilometers * 1000m * c
    return m


def convert_dms_to_decimal(degrees, minutes, seconds, is_negatif):
    return (degrees + (minutes+(seconds/60))/60) * (-1 if is_negatif else 1)

def convert_decimal_to_dms( decimal):
    minutes_seconds = decimal % 1 * 60
    minutes = int(minutes_seconds)
    secondes = (minutes_seconds - minutes) * 60
    return int(decimal), minutes, secondes

def convert_dms_string_to_decimal(dms_string):
    title = re.search('(\d{1,3}).(\d{1,2}).([\d\.]*).\s([NSEWO])', dms_string, re.IGNORECASE)
    degrees = int(title.group(1))
    minutes = int(title.group(2))
    seconds = float(title.group(3))
    orientation = title.group(4)

    if degrees < 0 or degrees >= 180:
        print("degrees field out of range, must be within [0, 180[")
        return
    if minutes < 0 or minutes >= 60:
        print("minutes field out of range, must be within [0, 60[")
        return
    if seconds < 0 or seconds >= 60:
        print("seconds field out of range, must be within [0, 60[")
        return
    return convert_dms_to_decimal(degrees, minutes, seconds, orientation in 'SWO')

if __name__ == "__main__":
    lats = {
        'lat1': convert_dms_string_to_decimal("42 40 43.83808  N"), # 42.67884391111111
        'long1': convert_dms_string_to_decimal("83 11 41.87927  W"), # -83.19496646388889
        'lat2': convert_dms_string_to_decimal("42 40 44.35053  N"), # 42.67898625833333
        'long2': convert_dms_string_to_decimal("83 11 41.88869  W") # -83.19496908055555
    }

    print lats
    a = haversine(lats['long1'], lats['lat1'],lats['long2'], lats['lat2'])
    print a/2
    lats = {
        'lat1': convert_dms_string_to_decimal("42 40 44.35053  N"), # 42.67884391111111
        'long1': convert_dms_string_to_decimal("83 11 41.88869  W"), # -83.19496646388889
        'lat2': 42.678915085,#42.67884391111111
        'long2': -83.195066874288 # -83.19496908055555
    }
    a = haversine(lats['long1'], lats['lat1'],lats['long2'], lats['lat2'])
    print a


    advanced = [
        {"y": convert_dms_string_to_decimal("42d40m45.15153s N"), "x": convert_dms_string_to_decimal("83d11m41.73259s W"), "priorite": 111, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m45.56451s N"), "x": convert_dms_string_to_decimal("83d11m42.17312s W"), "priorite": 122, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m45.24725s N"), "x": convert_dms_string_to_decimal("83d11m42.85466s W"), "priorite": 133, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m45.43535s N"), "x": convert_dms_string_to_decimal("83d11m43.40301s W"), "priorite": 144, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m46.21219s N"), "x": convert_dms_string_to_decimal("83d11m43.45800s W"), "priorite": 155, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m46.28430s N"), "x": convert_dms_string_to_decimal("83d11m42.94653s W"), "priorite": 166, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m46.01355s N"), "x": convert_dms_string_to_decimal("83d11m42.17641s W"), "priorite": 177, "gps": 2},
        {"y": convert_dms_string_to_decimal("42d40m46.45277s N"), "x": convert_dms_string_to_decimal("83d11m41.83221s W"), "priorite": 188, "gps": 2}
    ]

    print advanced

    a = haversine(83.1950059643718, 42.679157701026455,83.195056705, 42.6791805883)

    print a


