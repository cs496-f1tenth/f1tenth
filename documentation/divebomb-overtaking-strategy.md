## What is it?

The divebomb is an aggressive overtaking move where you brake way later than the car in front, dive to the inside of the corner, and take the apex before they can defend it. It's one of the oldest tricks in racing and it works because it's based on pure physics — whoever gets to the inside first owns the corner.

## How it works

You close the gap on the straight, wait until the last possible moment to brake, then cut hard to the inside. The opponent has already committed to their braking point and turn-in, so by the time they react you're already at the apex and they have no choice but to go wide. You come out in front.

The tradeoff is that you're taking a tighter line than ideal, so your exit speed out of the corner is usually worse. If the corner feeds onto a long straight, they can just re-pass you. Works best at the end of long straights that lead into slow corners.

## Why it's good for autonomous racing

Most overtaking strategies require predicting what the opponent is going to do — feints, defensive moves, etc. The divebomb doesn't really care. You just need to know:

- Is there a car in front of me?
- Is there a corner coming up?
- Is the inside line open?

If yes to all three, you go for it. That's a much easier problem for an autonomous system to solve than something like a dummy move which requires modeling opponent psychology.

## Implementation notes (F1TENTH)

The basic logic is: detect the opponent with YOLO, check if you're close enough and the inside is clear as the corner approaches, then swap your target path from the racing line to the inside attack line.

The main challenge is the braking zone — you need to brake later than normal but not so late that you run wide or into the opponent. Using MPC makes this cleaner since you can just encode the inside line as the new reference trajectory and let the optimizer figure out the braking naturally.

One thing to watch: on a Jetson Nano, re-planning mid-corner is expensive. Better to make the divebomb decision early (before the braking zone) and commit, rather than trying to re-evaluate on the fly.