This file outlines the topics published and subscribed to by the William full stack that uses AMCL, global trajectory, and pure pursuit. Implements a killswitch for safe driving.

|  | input | output |
| --- | --- | --- |
| map server node | in /maps add the .yaml and .pgm of the map | /map → occupancy grid, /map_metadata → info about the map ie resolution, size, origin |
| pure_pursuit node | trajectory file (from the [globaltraj.py](http://globaltraj.py) generator), /amcl_pose → localization from amcl, /odom → odometry  | /drive_raw → steering angle + speed commands, /pp/path → visualization of the trajectory in rviz, /pp/lookahead → the red balls its trying to follow |
| killswitch | /joy → joystick inputs, /drive_raw → from pure pursuit node | /drive_safe → commands that ONLY pass thru if killswitch is on |
| bringup.py | /drive_safe  | /joy, /teleop → manual drive commands, /drive_safe, /ackermann_drive → final commands to vesc (mux), /odom, /scan, /tf |

