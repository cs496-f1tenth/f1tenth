
## What is YOLO26?

YOLO26 is Ultralytics' latest real-time object detection model (released January 2026), built specifically for edge and low-power devices. It uses a camera feed to detect and localize objects in real time using bounding boxes.

Key features relevant to us:

- **NMS-free, end-to-end inference** — lower latency, simpler deployment pipeline
- **Up to 43% faster CPU inference** than previous YOLO versions
- **Improved small object detection** — relevant since opponent cars occupy a small portion of the camera frame at race distances
- **Runs on edge hardware** — designed with devices like the Jetson Nano in mind
## How It Could Help the Car

### 1. Obstacle Detection for Overtaking

The most immediate application is detecting static obstacles or opponent cars in the vehicle's path. YOLO26 can output bounding boxes indicating where an object is in the camera frame. This information can feed into the overtaking decision layer.
### 2. Supporting Rule-Based Overtaking

Were currently looking into rule-based overtaking. YOLO26 can serve as the perception trigger, i.e., rules only activate when a detection is confirmed. This reduces false maneuvers caused by noise or ghost detections.
### 3. Future Integration with MPC

With this in mind, we could also use YOLO26 in an MPC controller if we decide to go that route. A camera-based detector could feed obstacle position estimates into the MPC's constraint layer, allowing the optimizer to plan around detected objects rather than reacting to them.
## Next Steps to Explore

- Benchmark YOLO26n (nano variant) inference speed on Jetson Nano
- Investigate monocular depth estimation to pair with detections
- Define what output format the controller actually needs from perception
- Explore whether existing F1TENTH datasets or simulation environments (e.g., F1TENTH gym) can generate training data
## References

- [YOLO26 Official Docs](https://docs.ultralytics.com/models/yolo26/)
- [Ultralytics GitHub](https://github.com/ultralytics/ultralytics)
- [F1TENTH Official Site](https://f1tenth.org/)