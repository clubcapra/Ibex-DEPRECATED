animatics_smart_motor
============
Noeud ROS créé pour les [[Moteurs Animatics]] et conçu pour être partagé avec la communauté.
Le fonctionnement a été fortement basé sur l'ancien code en Java: https://github.com/ClubCapra-Deprecated/SmartMotor

## Calibration

Il y a 3 étapes à la calibration:

1. Faire avancer le robot avec la manette et s'assurer qu'il va droit. Ajuster le paramètre speed_ratio, qui représente la difference entre les vitesses de chacun des moteurs. [droit, gauche]. 

2. Afficher les obstacles dans rviz et deplacer le robot en ligne droite. Les obstacles devraient rester a la même place et un mur droit devrait rester droit. Ca va assez bien de le tester dans le corridor des clubs. Si on a un problème, il faut ajuster le paramètre position_ration. C'est la différence entre la lecture des encodeurs et ce qu'on doit interpreter. C-a-d que si une roue dit qu'elle a tourne de 1 tour mais qu'elle a seulement fait 0.95 tour, on le corrige ici. ca devrait etre lie a la correction de vitesse ci-haut, possiblement simplement l'inverse des valeurs (si on doit faire tourner une roue à 0.98 de la vitesse de l'autre roue, les chances sont que l'autre roue devra multiplier sa distance parcourée par 0.98)

3. Une fois que le robot va droit et qu'il lit bien qu'il va droit (corrige avec speed ratio et position ratio),
on peut tweaker la largeur pour que la rotation soit bien calculée. Le calcul de l'orientation se fait avec la moyenne de distance parcourue des 2 roues divisee par la largeur. Plus la largeur est haute, moins le robot pense qu'il a tourne. Encore une fois, le corridor des clubs est un bon test: on place le robot au milieu et on le fait pivoter. Apres un tour, les deux murs du corridor devraient s'enligner avec ceux de la premiere lecture. Si le robot n'a pas assez tourne, on diminue la largeur, et vice-versa

##  Paramètres 
#### Resolution
Nombre d'encoder counts du moteur pour un tour complet

Valeur par défaut:4000.0

#### counts_rpm
Nombre de counts par seconde par rpm

Valeur par défaut:542.29383

#### counts_revs
Nombre de counts par sec carrée par revolution par seconde carrée (Pour l'acceleration)

Valeur par défaut:16.15444

#### counts_sec
Nombre de counts pour une seconde d'attente

Valeur par défaut:4069.0

#### gear_ratio
Tours des moteurs qui font tourner la roue de 1 tour

Valeur par défaut:40.0

#### wheel_diameter
Diamètre de la roue, en mètres
Valeur par défaut:0.305

#### robot_width
Largeur du robot.

Valeur par défaut:0.6096

#### nb_motors
Nombre de moteurs à contrôler. Doit être un multiple de 2.

Valeur par défaut:2

#### max_speed
Limite logicielle pour la vitesse maximale du robot. En haut de cette valeur, il devient instable.

Valeur par défaut:3.0

#### broadcast_address
Adresse de broadcast par laquelle doit commencer chaque message envoyé aux moteurs. Les adresses des moteurs sont cette valeur +1 et +2.

Valeur par défaut:0x80

#### serial_port
Nom du port série pour communiquer avec les moteurs.

Valeur par défaut:"/dev/ttyUSB1004"

#### default_accel
Accélération par défaut envoyée aux moteurs. Une valeur trop haute rend le robot très instable et dangereux.

Valeur par défaut:10

#### baudrate
Baudrate utilisé pour la communication série. Par défaut, cette valeur est 9600, mais elle est modifiable à l'exécution.

Valeur par défaut:38400

#### max_timeout_count
Nombre de fois qu'un timeout de communication survient avant qu'on considère que le E-Stop est activé.

Valeur par défaut:2

#### watchdog_timeout
Délais maximal (en secondes) après lequel on considère qu'une communication a échoué.

Valeur par défaut:0.15

#### publish_rate
Nombre de publications de l'odométrie des roues par seconde.

Valeur par défaut:50

#### covariance_matrix
Matrice de covariance utilisée par le filtre de Kalman.
Chaque colonne représente la fiabilité associée à une valeur du message d'odométrie. (x, y, z, roll, pitch, yaw)?.

Plus la valeur est basse, plus la donnée est fiable.

Valeur par défaut:
 """1.0, 0,   0,   0,   0,   0,
    0,   1.0, 0,   0,   0,   0,
    0,   0,   1.0, 0,   0,   0,
    0,   0,   0,   1.0, 0,   0,
    0,   0,   0,   0,   1.0, 0,
    0,   0,   0,   0,   0,   1.0"""

#### speed_ratio
Ratios permettant d'ajuster la vitesse envoyée aux moteurs. Ils ne sont pas parfaitement identiques et, si cette valeur n'est pas réglée, le robot risque de se déplacer vers la gauche ou la droite.

Valeur par défaut:"1.0, 1.0"

#### position_ratio
Ratio permettant d'ajuster la position retournée par les encodeurs.

Valeur par défaut:"1.0, 1.0"

##  Topics 
#### /odom
Message de type [nav_msgs/Odometry](http://docs.ros.org/api/nav_msgs/html/msg/Odometry.html) retournant l'odométrie calculée à partir des données des encodeurs. L'angle retourné n'est pas très fiable à cause de plusieurs problèmes (roues croches, accélération non prise en compte, ...).

Il est donc important d'utiliser un filtre de Kalman afin de bien connaître la position du robot.

