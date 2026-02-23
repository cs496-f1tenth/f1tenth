# YOLO26 Dynamic Overtaking Strategy Switching in F1TENTH

Below is a practical implementation strategy for using our CUDA-enabled Jetson Nano to detect an opponent vehicle using YOLO26 and dynamically switch between two racing stacks:

- **Conservative / Nominal Stack** – optimized for stability and lap time consistency  
- **Aggressive / Overtake Stack** – activated when an opponent is detected ahead  

In this instance, our goal is not full scene understanding but rather to answer one question in real time:

> **Is there a car in front of us that requires overtaking behavior?**

---

# 1. System Motivation

In F1TENTH racing, computation is limited. The Jetson Nano provides CUDA acceleration, but CPU resources are constrained.  

Running full neural network inference in PyTorch on the CPU is inefficient and introduces latency spikes. Therefore, the correct architectural decision is:

- Use the **GPU for inference**
- Minimize CPU copy overhead
- Convert perception output into a stable behavior trigger

The system architecture becomes:
```
Camera -> YOLO26 (TensorRT on GPU) -> Opponent State Estimator -> Behavior Manager -> Control Stack
```

---

# 2. Baseline Concepts

## 2.1 Why YOLO26?

YOLO26 is suitable for embedded systems because:

- End-to-end detection (no heavy post-NMS stage)
- Small model variants (e.g., yolo26n)
- Optimizable via TensorRT
- Good real-time performance at lower resolutions (320–416px)
- It's the newest, state of the art CV technology as of writing!

For this application, detection accuracy beyond “opponent ahead or not” is unnecessary. A lightweight model is preferable to maximize frame rate and determinism.

---

## 2.2 Why TensorRT?

Running YOLO through PyTorch:

- Adds Python overhead
- Increases latency
- Produces inconsistent frame timing

Exporting to **TensorRT (.engine)**:

- Compiles the model into an optimized CUDA execution graph
- Uses FP16 where possible
- Minimizes CPU interaction
- Produces stable inference latency

This ensures the detection pipeline does not interfere with control loop timing.

---

# 3. Simplifying the Vision Problem

We do **not** need general object detection.  
We only need to detect:

> "Opponent vehicle in the forward corridor."

This allows us to simplify.

---

## 3.1 Region of Interest (ROI)

Instead of running detection on the entire image:

- Crop to center 60–70% width
- Focus on lower-middle region of image
- Ignore irrelevant track-side clutter

This should not only reduce compute, but it should also (hopefully) reduce false positives.

---

## 3.2 Single-Class Training

Rather than detecting multiple object classes:

- Train only on `opponent_car`
- Or fine-tune on F1TENTH vehicle dataset

This improves reliability under race lighting conditions.

---

# 4. Converting Detections into Behavior Decisions

A key mistake would be switching racing stacks directly from a single detection frame.

Instead, we should look into implementing a **state estimator with hysteresis.**

---

## 4.1 Static vs Dynamic Stack Behavior

### Static Approach (Naive)

- Always follow optimal racing line
- If opponent appears -> no adaptation
- Result: emergency braking or collision

---

### Dynamic Approach (Behavior Switching)

- Nominal state: follow optimal racing line
- Opponent detected ahead -> switch to aggressive stack
- Aggressive stack modifies:
  - Cost weights
  - Allowed deviation from centerline
  - Speed profile
  - Safety margins

---

# 5. State Machine for Opponent Detection

Instead of binary toggling, we should implement a small state machine.

Potential states:

- `NORMAL`
- `OPPONENT_CONFIRMED`
- `OVERTAKE_ACTIVE`
- `COOLDOWN`

---

## 5.1 Debouncing Logic

To prevent oscillation:

- Require N detections within M frames (e.g., 3 of 5)
- Require K consecutive misses before deactivating (e.g., 8)
- Add cooldown period after overtaking

This would prevent:

- Overly frequent mode switches
- Abortive overtakes
- Control instability during occlusion

---

# 6. Jetson Nano Performance Optimization

## 6.1 Max Performance Mode
```
sudo nvpmodel -m 0
sudo jetson_clocks
```

This prevents frequency scaling during racing.

---

## 6.2 Resolution Selection

Start with:

- `yolo26n`
- 320 (or try 416) resolution

Trade-offs:

- Higher resolution -> better far detection
- Lower resolution -> lower latency for more stable timing

---

# 7. Behavioral Stack Architecture

Two design options could require further exploring.

---

## Option A: Two Independent Controllers

- Conservative controller
- Aggressive controller
- Multiplex steering/throttle outputs

Downside:
- Harder to guarantee deterministic timing

---

## Option B: Single Controller with Mode-Dependent Parameters

One planner/controller, but switch:

- Cost weights
- Constraint bounds
- Velocity limits
- Clearance margins

Not necessarily the route Professor Choi wanted our group to take, but could be interesting to look into.
