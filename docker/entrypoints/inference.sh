#!/bin/bash

while getopts "l:" opt; do
    case $opt in
        l) LAUNCH_FILE=$OPTARG;;
        *) helpFunction ;;
      esac
done

helpFunction()
{
    echo ""
    echo "Usage: $0 -l [launch-file]"
    echo "Options:"
    echo -e "\t-l: Launch file"
    exit 1
}

if [ -z "$LAUNCH_FILE" ]; then
    echo "Please provide the Launch file"
    helpFunction
fi

cd /root/OpenPCDet
python setup.py develop

cd /root/ros2_ws
source /opt/ros/foxy/setup.bash
source install/setup.bash
ros2 launch pcdet_ros2 $LAUNCH_FILE