#! /usr/bin/env python

from base_ai import BaseAI
import math
import numpy as np


class CaroAI(BaseAI):

    def __init__(self):
        super(CaroAI, self).__init__("caro_ai")

    def loop(self):
        i = 0
        scan = self.get_scan()
        #print "Beep boop je suis Caro."

        pos = []
        while i <= 540:

            if scan.ranges[i] < 20:
                if 90 >= i >= 0:
                    angle = 45 - i/2
                    x = -scan.ranges[i]*math.sin(angle)
                    y = scan.ranges[i]*math.cos(angle)

                elif 90 < i <= 270:
                    angle = (i-90)/2
                    x = scan.ranges[i]*math.sin(angle)
                    y = scan.ranges[i]*math.cos(angle)

                elif 270 < i <= 450:
                    angle = (450-i)/2
                    x = scan.ranges[i]*math.sin(angle)
                    y = -scan.ranges[i]*math.cos(angle)

                else:
                    angle = (i-90)/2
                    x = -scan.ranges[i]*math.sin(angle)
                    y = -scan.ranges[i]*math.cos(angle)

                pos.append((x, y))
            i += 1
        print pos

        self.set_velocity(0, 0)

ai = CaroAI()
ai.run()
