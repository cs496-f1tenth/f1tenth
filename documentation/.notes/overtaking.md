# Notes Regarding Overtaking in Races
## Key Factors:
- Distance from car in front of us - how much space do we need to complete an overtake
- Size of gap on left or right - how wide is the car
- Is a turn coming up? - overtakes are simplest in a straightaway
- What speed are we at? - will we lose control if a maneuver is attempted
- Slowing down (aborting overtake) if an unexpected obstacle appears or if the car in front moves and we lose space.
- Model Predictive Control (not Learning Model) seems to be a common decision making model for overtaking

## Other Strategies:
- If we can detect a car is behind us we could hold an advantage by trying to align ourselves with the car in order to prevent being overtaken.
- We should look into how overtaking works in curves; i.e. taking the opportunity to overtake when the car in front turns too wide.

### Readings: 
Here are some research papers involving the topic of overtaking in autonomous vehicles.
- [Model Predictive control with overtaking maneuvers built into the path planning](https://ieeexplore.ieee.org/document/10928922)
- [Systematic review of different overtaking strategies in autonomous vehicles](https://www.sciencedirect.com/science/article/pii/S2666691X24000393)
- [Model Predictive Control that switches to a dedicated overtaking controller when needed](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/itr2.12507)
