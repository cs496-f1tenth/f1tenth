The strategy switch swaps between two different racing stacks triggered by detecting an opponent car ahead. The controller follows the global trajectory by default. When an opponent is detected, it switches to a different racing strategy. When the track clears, it switches back.
## How it works

YOLO runs inference on the camera stream and checks whether any bounding boxes are returned. It publishes a `Bool` to `/car_detected` on every frame — `True` if a car is present, `False` otherwise.

The controller subscribes to that topic and tracks the current detection state. All it does it wait for the topic to publish `True` , which happens when the YOLO model detect a car within range.
## Implementation (F1tenth)

The detection node is decoupled from the controller. It publishes a `Bool` and knows nothing about trajectory switching, the controller handles that logic independently.

The `/car_detected` topic is verified with a lightweight subscriber node that logs incoming signals before the full controller integration is wired up.