# Fish Flocking Simulation

## Introduction

This project demonstrates the flocking behavior of fish in a simulated pond environment using Processing. By implementing steering behaviors, the simulation provides a visually appealing and dynamic model of how fish might interact within a shared space, reacting to their environment and each other.

## Demo

![Fish Flocking Behavior Simulation Demo](https://github.com/Reztreal/FishSteeringBehaviour/blob/main/fnb.gif)

## Features

- Two distinct flocks of fish.
- Interactive bait particles that attract fish, simulating feeding behavior.
- Edge avoidance, where fish steer away from the boundaries of the pond to remain within the visible area.
- Flocking behaviors including separation, alignment, and cohesion among members of the same flock.

## How It Works

The simulation leverages the concept of boids, a term coined by Craig Reynolds in 1986 to describe a simplified model of flocking behavior. Each boid in the simulation follows three basic rules – separation, alignment, and cohesion – to simulate natural fish movement. Additional behaviors such as attraction to bait and edge avoidance are also implemented to enhance realism.

## Setup

To run this project, you need to have Processing 3 or later installed on your computer. Processing is available for download at [https://processing.org/download/](https://processing.org/download/).

## Usage

1. Clone the repository or download the source code.
2. Open the `.pde` file in Processing.
3. Press the Run button to start the simulation.
4. Click with the left mouse button to drop bait of type 1, and right-click (or control-click on Mac) to drop bait of type 2. Watch as the fish flock towards and interact with the bait.

## License

This project is open source and available under the MIT License. For more details, see the LICENSE file in the repository.
