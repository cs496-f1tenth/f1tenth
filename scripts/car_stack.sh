#!/usr/bin/env bash
set -euo pipefail

PIDS=()

cleanup(){
  echo "[*] car_stack script stopping..."
  #kill each launched process
  for pid in "${PIDS[@]}"; do
    kill -TERM "$pid" 2>/dev/null || true
  done

  sleep 1
  for pid in "${PIDS[@]}"; do
    kill -KILL "$pid" 2>/dev/null || true
  done
  echo "[*] car_stack script stopped."
}

trap cleanup EXIT INT TERM HUP

source /opt/ros/humble/setup.bash
source /home/william/ros2_ws/setup.bash

start(){
  local name="$1"
  shift
  local cmd="$*"

  #logs per process so that we can check them individually
  local log="$HOME/${name}.log"

  echo "[car_stack] starting $name: $cmd"
  bash -lc "$cmd" >>"$log" 2>&1 &
  PIDS+=($!)
  echo "[car_stack] $name pid=${PIDS[-1]} log=$log"
}

start_bg "bringup"      "ros2 launch william_full_stack bringup.py"
start_bg "killswitch"   "ros2 run william_full_stack killswitch.py"
start_bg "map_server"   "ros2 launch william_full_stack map_server.launch.py"
start_bg "amcl"         "ros2 launch william_full_stack amcl.launch.py"
start_bg "pure_pursuit" "ros2 launch william_full_stack pure_pursuit.launch.py"

echo "[car_stack] all started. Ctrl+C to stop all."
wait
