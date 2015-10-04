__author__ = 'jstcyr'
# -*- coding: utf-8 -*-

import re


def ConvertToDecimalDegrees(coordinates):
    #already in decimal degrees
    if re.match("\A-?\d{1,3}(?:.\d+)?\Z", coordinates):
        return coordinates

    #in decimal degrees with orientation
    match = re.match("\A(\d{1,3}(?:.\d+)?)\s*([NSEW])\Z", coordinates)
    if match:
        return -float(match.group(1)) if match.group(2) in 'WS' else float(match.group(1))

    #in degrees decimal minutes
    match = re.match("\A(\d{1,3})\s*°\s*(\d{1,2}(?:.\d+)?)\s*'\s*([NSEW])\Z", coordinates)
    if match:
        decimal = float(match.group(1)) + float(match.group(2))/60
        return -decimal if match.group(3) in 'WS' else decimal

    #in degrees minutes seconds
    match = re.match("\A(\d{1,3})\s*°\s*(\d{1,2})\s*'\s*(\d{1,2}(?:.\d+)?)\s*\"\s*([NSEW])\Z", coordinates)
    if match:
        decimal = float(match.group(1)) + float(match.group(2))/60 + float(match.group(3))/3600
        return -decimal if match.group(4) in 'WS' else decimal

    #else coordinates aren't valid
    raise ValueError("Invalid coordinates format. Please use either decimal degrees, degrees decimal minutes or degrees minutes seconds format.")
