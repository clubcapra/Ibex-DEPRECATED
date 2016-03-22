#!/bin/bash
#
#Script bash to test all the motor by sending ros command to it
#Author: Maxime St-Pierre <me@maximest-pierre.me>
#
echo "Testing motor"
sleep 5
echo "Testing front right motor"

(rostopic pub /roboteq_driver/front/right/cmd roboteq_msgs/Command 0 500 -r 10)

sleep 5

echo "Done testing motor"

sleep 1

echo "Testing left front motor"

 (rostopic pub /roboteq_driver/front/left/cmd roboteq_msgs/Command 0 500 -r 10)

sleep 5

echo "Done testing motor"

sleep 1

echo "Testing right rear motor"

 (rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 500 -r 10)

echo "Done testing motor"

sleep 1

echo "Testing left rear motor"

 (rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 500 -r 10)

sleep 5

echo "Done testing motor"

sleep 1

echo "Testing right rear motor"

 (rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 500 -r 10)

sleep 5

echo "Testing done killing all motor"

killall -9 roscore