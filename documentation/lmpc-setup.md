# Racing-LMPC-ROS2 Setup
In order to set up Berkeley's LMPC (Learning Model Predictive Control) and Tracking MPC for autonomous racing vehicles, first, open a web browser and go to:

`https://github.com/MPC-Berkeley/Racing-LMPC-ROS2`

From this page, you can review the code, documentation, and clone the repository to your local machine.

## System Requirements
To ensure reproducibility, this project uses a fixed software stack; the same used thus far.
### Operating System
- **Ubuntu 22.04**
### ROS Distribution
- **ROS 2 Humble (LTS)**
### Additional Dependencies
- **CasADi >= 3.6.3** (must be built from source)
    - **Note:** Instructions will be added in the future
- **IPOPT** (non-linear optimization)
- **LLVM** (for CasADi JIT compilation)
- **Foxglove Studio** (optional, visualization only. rviz will work)

## Setting up the Repository
After navigating to the repository page, clone the code:
```bash
git clone https://github.com/MPC-Berkeley/Racing-LMPC-ROS2.git
cd Racing-LMPC-ROS2
git checkout humble-release
```

## Install ROS Depdencies
```bash
rosdep update
rosdep install --from-paths src --ignore-src -r -y
```

## Build Instructions
```bash
colcon build --packages-up-to racing_lmpc_launch \
  --cmake-args -DCMAKE_BUILD_TYPE=Release
```
After building:
```bash
source install/setup.bash
```

## Running Learning MPC
### Visualization Setup (Foxglove preferred)
1. Open **Foxglove Studio**
2. Load the layout file:
```
lmpc.foxglove.json
```
3. Open a Foxglove Bridge connection with default settings
### Terminal 1 - Launch Foxglove Bridge
```bash
source install/setup.bash
ros2 launch foxglove_bridge foxglove_bridge_launch.xml
```
### Terminal 2 - Launch any simulator
#### Base Simulator
```bash
source install/setup.bash
ros2 launch racing_lmpc_launch sim_barc_lmpc.launch.py
```
#### Tracking MPC
```bash
source install/setup.bash
ros2 launch racing_lmpc_launch sim_barc_tracking_mpc.launch.py
```
#### IAC Putnam Full Course
```bash
source install/setup.bash
ros2 launch racing_lmpc_launch sim_putnam_config_a_tracking_mpc.launch.py
```
##### Visualization Notes
- Increasing the line scale in the 3D panel can make the car easier to track
- Note: The track is very large