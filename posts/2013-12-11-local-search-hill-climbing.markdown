---
title: Local Search: Hill Climbing Search
subtitle: A Short Look at Hill Climbing Search and Variations
date: 2013-12-11
icon: chart02
---

## Introduction
Local Search is a method that is used to solve optimization problems, where we are 
after a solution\'s state, and the path to the goal is not the solution it self. This contrast
from shortest-path problems we can solve with A* and Dijkstra\'s Algorithm, in that the solution
it is the path from a start to a goal node. We only care about a final configuration.

Local search is a way to solve problems like vehicle routing, portfolio management, scheduling, 
and positioning problems without having to explore all possible solutions which increases in 
complexity with the number of variables.

In this post I will be quickly covering what Hill Climbing, Simulated 
Annealing, Local Beam, and Genetic Search are and what their algorithms look like.

The important thing to note about Local Search is that we must be aware that
the search space has a sort of landscape that has slope with global and local maxima and minima
at which our algorithms can get stuck, and since these algorithms do not explore all areas of a 
search space it is also possible to arrive at a solution which is good enough to solve a problem,
such as in the case of scheduling.

The majority of the algorithms are derivations of those presented in *AIMA* by Peter Norvig.

## Hill Climbing

Hill Climbing is an algorithm that move in a direction of increasing value, and terminates once it reaches a peak. At every step of the way it uses a heuristic evaluation function, which we can call $h(n)$ to evaluate its state and the state of all its neighboring solutions.

After using $h(n)$ to evaluate the neighboring solutions it makes a move to the next best state, in other words, we can consider Hill Climbing to be greedy. Since this is a greedy algorithm we know it is likely that we will reach a local maxima sooner than later, but weather or not this is a solution good enough is dependent on the problem definition.

The problem with hill climbing is that it is possible to get stuck at a local maxima which does not solve our problem. Similarly, it is also possible to reach a plateau where we do not have a next best move and we can wonder infinitely back and forth if we allow sideways moves.

### Best First Hill Climbing Algorithm
````java
// Pseudo Code

function h(State s) {
  // Heuristic Evaluation Function
}

// Pseudo Code
function HillClimbing(State s) {
    State best = s;
    State current;
    while (true) {
        current = best;
        for (State next : s.nextStates()) // foreach...in..
            // Move to the next best possible state
            best = h(best) < h(next) ? next : best; 
        
        // If current & best are STILL the same, then we reached a peak.
        if (best == current)
            return best;
    }
}
```` 

### Hill Climbing Variations
To get around some of the limitations on Hill Climbing like reaching a plateau 
or a local maxima we can  go about allowing a limited number of sideways moves 
before failing, or we can go about making choices in a stochastic manner or 
simply doing a randomized restart when the Hill Climbing gets stuck.
 
### Stochastic Hill Climbing
We can try choosing a randomized uphill move, rather than a greedy one. This would 
still move us towards a solution, but would lead us to explore different areas of the search space, 
and depending on the problem it could lead to better solutions.

````java
// Pseudo Code

function h(State s) {
  // Heuristic Evaluation Function
}

function List::ChooseRandom() {
    // return move with probability proportional to the improvement.
}

function HillClimbing(State s) {
    State best = s;
    State current;
    List betterMoves = List();

    while (true) {
        current = best;

        // Look for better moves
        for (State next : s.nextStates()) // foreach...in..
            if (h(best) < h(next))
                betterMoves.add(next);
        
        // Choose randomly, from better moves -- if any
        if (betterMoves.length() > 0)
            best = betterMoves.chooseRandom();

        // If current & best are STILL the same, then we reached a peak.
        if (best == current)
            return best;
    }
}
```` 


### Fist Choice Hill Climbing
First Choice Hill Climbing is all about generating successors randomly until a better
one than our current state is generated. The reason you would want to do this is that 
in certain problems the number of successors states can be too big to compare directly
to the current state, so generating randomly and moving to a better state may yield a 
better outcome in less time.

````java
// Pseudo Code

function h(State s) {
  // Heuristic Evaluation Function
}

function generateRandomState() {
    // return a new randomly generated state.
}

function HillClimbing(State s) {
    State best = s;
    State current;

    while (true) {
        current = best;

        // Look for better moves.
        for(i = 0; i < THRESH_HOLD; i++) // foreach...in..
        {
            generated = generateRandomState();
            if (h(best) < h(generated)) {
                best = generated
                break;
            }
        }

        // If current & best are STILL the same, then we reached a peak.
        if (best == current)
            return best;
    }
}
````


### Random Restart Hill Climbing  
Random Restart Hill Climbing is all about doing a series of Hill Climbing searches from 
randomly generated initial states, until a goal is found. So every time the algorithm gets 
stuck at a local maxima, or plateau the algorithm simply does a random restart and tries again and again.

````java
// Pseudo Code
function main() {
    State current = new State(...); // Initial state    
    while (true) {
      solution = HillClimbing(current)
      if (isSolution(solution))
         break;
      // Solution good enough has not been found do a randomized restart.
      current = generateRandomState()
    }
}

function generateRandomState() {
    // Generate a Random State to start from.
}

function h(State s) {
  // Heuristic Evaluation Function
}

// Best-First Hill Climbing, but may be any type of hill climbing.
function HillClimbing(State s) {
    State best = s;
    State current;
    while (true) {
        current = best;
        for (State next : s.nextStates()) // foreach...in..
            // Move to the next best possible state
            best = h(best) < h(next) ? next : best; 
        
        // If current & best are STILL the same, then we reached a peak.
        if (best == current)
            return best;
    }
}
```` 

## Conclusion

Hill Climbing appears to be a powerful method for local search problems where we are looking to 
get to a solution configuration. Some version of the algorithm like the Greedy Best First will be 
incomplete, and fail to find a solution where there is one if it gets stuck in a local maxima, or plateau.
We can also see that that can be resolved by adding in a randomized restart which will allow the 
hill climbing to start in another location of the search space. The goal was to more or less introduce the general idea of hill climbing and present some pseudo code to possible implementations.

## Additional References
[Artificial Intelligence a Modern Approach](http://aima.cs.berkeley.edu/)<br>
[Hill Climbing](http://en.wikipedia.org/wiki/Hill_climbing)<br>
[Local Search](http://en.wikipedia.org/wiki/Local_search_(optimization))<br>
