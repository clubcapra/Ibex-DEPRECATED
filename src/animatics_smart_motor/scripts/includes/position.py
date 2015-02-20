import time
import math
from config import Config


class Position:
    x = 0
    y = 0
    yaw = 0
    position_time = time.time()
    linear_vel = 0
    angular_vel = 0

    def __init__(self):
        pass

    def move(self, l, r):
        elapsed = time.time() - self.position_time
        d = (l + r) / 2.0
        th = (r - l) / Config.get_robot_width()

        x = math.cos(th) * d
        y = -math.sin(th) * d

        self.position_time = time.time()

        self.linear_vel = d / elapsed
        self.angular_vel = th / elapsed

        self.x += (math.cos(self.yaw) * x - math.sin(self.yaw) * y)
        self.y += (math.sin(self.yaw) * x + math.cos(self.yaw) * y)
        if th != 0:
            self.yaw = self.yaw + th


