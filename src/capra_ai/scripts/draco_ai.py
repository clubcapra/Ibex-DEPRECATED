#! /usr/bin/env python

from base_ai import BaseAI
import math
import numpy as np


class DracoAI(BaseAI):

    def __init__(self):
        super(DracoAI, self).__init__("draco_ai")

    def loop(self):
        scan = self.get_scan()
        print "AVADA KEDAVRA"
        self.set_velocity(0.5, 2)

ai = DracoAI()
ai.run()
