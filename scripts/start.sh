#!/usr/bin/env bash
set -e

export ROS_LOCALHOST_ONLY=0
export ROS_DOMAIN_ID=0

ssh -t car '~/car_stack.sh' &

sleep 3

rviz2
kill %1
