# F1TENTH Scripts

This directory contains scripts to help optimize some pain points during development.

## car_stack.sh
This script is meant to be run on the vehicle itself. It launches all of the processes required for operating the car. This script also bundles all of the background processes and cleanly terminates them together. The script is set up in a very simple manner to make it easier to add or remove processes later as needed. Currently the script launches 5 ros2 processes:
- bringup.py
- killswitch.py
- map_server.launch.py
- amcl.launch.py
- pure_pursuit.launch.py

Ctrl+C can be used to terminate all of the processes together.

## start.sh
This script is meant to be run on the pit laptop. When run, it will ssh into the vehicle and run the ```car_stack.sh``` script. It will then launch RViz2 in order to visualize and monitor the vehicle. Closing RViz2 will automatically terminate the processes created by ```car_stack.sh```

