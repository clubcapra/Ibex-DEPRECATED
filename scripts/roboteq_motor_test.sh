#!/bin/bash
#
#Script bash to test all the motor by sending ros command to it
#Author: Maxime St-Pierre <me@maximest-pierre.me>
#
echo "Testing motor"
sleep 5
echo "Testing front right motor"

for i in 1 2 3 4 5
do
	sleep 0.1
	rostopic pub /roboteq_driver/front/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/front/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/front/right/cmd roboteq_msgs/Command 0 10000
	sleep 0.1
	rostopic pub /roboteq_driver/front/right/cmd roboteq_msgs/Command 0 10000
done

echo "Testing front right motor done"

for j in 1 2 3 4 5
do

	sleep 0.1
	rostopic pub /roboteq_driver/front/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/front/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/front/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/front/left/cmd roboteq_msgs/Command 0 5000
	
done

echo "Testing front left motor done" 

echo "Testing rear left motor"

for k in 1 2 3 4 5
do 
	sleep 0.1
	rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/left/cmd roboteq_msgs/Command 0 5000

done

echo "Testing rear left motor done"

echo "Testing rear right motor"

for l in 1 2 3 4 5
do
	sleep 0.1
	rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 5000
	sleep 0.1
	rostopic pub /roboteq_driver/rear/right/cmd roboteq_msgs/Command 0 5000
done

echo "Done testing rear right motor"
