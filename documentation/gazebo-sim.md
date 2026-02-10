Gazebo Sim is a 2D/3D robotics simulator that we can use to simulate ROS2 and ensure that it is working properly along with being able to drive the car inside of the simulator.
## Gazebo Sim Installation Guide

### Prerequisites
Ensure that before installing Gazebo that you have ROS2 installed onto your device before proceeding.

## Install from the ROS repository

Install the Gazebo-ROS integration using the default pairing for Humble, Gazebo Fortress.

```
sudo apt update
sudo apt install -y \
  ros-humble-ros-gz \
  ros-humble-ros-gz-sim \
  ros-humble-ros-gz-bridge \
  ros-humble-ros-gz-sim-demos \
  gazebo
```

## Verify Installation

Run this to check the Gazebo Version, along with verifying it installed properly

```
gz --help
```

Expected Output:
```
gz help [options]
...
```

## Verify the Sim works with ROS2

Start a small demo world:

```
ros2 launch ros_gz_sim gz_sim.launch.py gz_args:="shapes.sdf"
```

You should see the simulator open and if the timer at the bottom of the simulator starts running, then you are done!
