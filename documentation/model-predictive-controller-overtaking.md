
This document is based on the paper, "A Model Predictive Control Strategy for Overtaking in Autonomous Vehicles", which analyzes the effectiveness of the model predictive controller(MPC) as an overtaking strategy. 

The paper dives into an offshoot of MPC called Nonlinear MPC(NMPC). The paper proposes an approach that incorporating dynamic adjustments to reference trajectory. 

Dynamic adjustments to reference trajectory refers to how the authors adjusted the MPC formula, typically, You pre-compute the entire path offline (e.g., "follow the racing line"), so the reference never changes, an example of this is pure pursuit, where the waypoints never change. The authors adjustment was that the reference changes in real time, based on the conditions that the car perceives.

An example scenario would be something like this. 

In F1TENTH racing:

**Static:**

- Always follow pre-computed optimal racing line
- If opponent blocks it → crash or emergency brake

**Dynamic:**

- Nominal reference = optimal racing line
- Opponent detected ahead → reference trajectory **deforms** around opponent
- Creates a "bubble" that avoids the opponent while staying close to optimal line


The adjustments made were focused on how to minimize overhead while running an active controller while racing. The focused on simplifying the equation that MPC has to do by linearizing lane boundaries, collision regions by using half spaces, thus resulting in a "simpler" optimization problem. Though it is still non-linear due to dynamics. 

Problem: The paper runs with the assumption that the **Faster vehicle knows what the slower vehicle is going to do.** This was done to prove the concept of NMPC, and even ran a test that is similar to the kind of demo we want to do with clean overtaking an collision avoidance, but it assumes shares telemetry. 

At the end of the paper it is stated, 

"Future work will involve further refinements to the strategy, incorporating more complex scenarios and exploring real world implementation challenges. This includes scenarios with limited information and uncertainties"

Redwan et al., "A Model Predictive Control Strategy for Overtaking in Autonomous Vehicles," 2024 12th International Conference on Systems and Control (ICSC)



