#! /usr/bin/env python

from base_ai import BaseAI
import math
import numpy as np


class CaroAI(BaseAI):

    def __init__(self):
        super(CaroAI, self).__init__("caro_ai")

    def loop(self):
        scan = self.get_scan()
        print "Beep boop je suis Caro."
        self.set_velocity(0.5, 0)

ai = CaroAI()
ai.run()
