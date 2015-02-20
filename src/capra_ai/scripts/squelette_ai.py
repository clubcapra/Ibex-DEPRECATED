#! /usr/bin/env python
# coding=utf-8

from base_ai import BaseAI


class SqueletteAI(BaseAI):

    def __init__(self):
        super(SqueletteAI, self).__init__("nom_du_ai_ici")
        # Initialiser les variables ici

    def loop(self):
        # Par defaut, loop sera exécuté 10 fois par seconde (au maximum).
        # Il est possible de modifier cette fréquence avec self.set_frequency().

        # Récupère le dernier scan envoyé par le lidar.
        # Pour avoir plus d'informations sur cette variable:
        # http://docs.ros.org/api/sensor_msgs/html/msg/LaserScan.html
        scan = self.get_scan()

        # À la fin, il faut envoyer une vélocité aux moteurs.
        # La 1re valeur est la vitesse linéaire et la 2e la vitesse angulaire (de rotation).
        # Dans cette exemple, le robot avance en ligne droite à 1m/s.
        self.set_velocity(1, 0)


ai = SqueletteAI()
ai.run()
