#!/bin/bash
export ROS_DOMAIN_ID=30
export RMW_IMPLEMENTATION="rmw_cyclonedds_cpp"
cd /root/OpenPCDet
python setup.py develop

cd /root/ros2_ws
source /opt/ros/foxy/setup.bash
source install/setup.bash
ros2 launch pcdet_ros2 pcdet.launch.py