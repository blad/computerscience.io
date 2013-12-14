---
title: Adversarial Search
subtitle: Minimax and Alpha-Beta Pruning
date: 2013-12-2013
icon: award04
---
## Introduction

Adversarial Search corresponds to searching a state space where the decisions
are contingent on decisions made by others. When referring to adversarial search 
we want to consider the two (or more) agents involved as being *optimal* decision
makers, and the agents goals as being opposite, so that can have a clear distinction
of who won at any particular ending state.

One of the most known algorithms for adversarial search is named Minimax, and it 
assumes that a game is a zero-sum game of perfect information, which means that a the
games can be scored with equal and opposite values for opponents, and we know the state
of the entire game at any given point.

## Relationship

In minimax, the two players are MIN and MAX, which try to minimize and maximize their 
utility scores respectively, MIN always moves to states with the best minimum, while 
MAX does the opposite and moves to states with the best maximum value, but the decisions 
they make are based on the decisions that their opponents could make.

Min chooses the min value among the max values that MAX chooses after min makes a move.
Max chooses the max value among the min values that MIN chooses after max makes a move.

As you can see this leads to a recursive definition for the values our players can choose.
And so our base case comes only when we reach a terminal state, and at that point the
game is scored with an appropriate utility function for the game, and the values propagate
upwards, undoing the recursion.

> $\begin{array} \\
        minimax(s) = \left\{
                \begin{array} \\
                Utility(s) & : if\ s\ is\ terminalState \\
                max\{minimax(t)\} & : if\ player\ is\ MAX \\
                min\{minimax(t)\} & : if\ player\ is\ MIN \\
                \end{array}
             \right. \\ 
             \\
        such\ that: \\ 
                \qquad s\ is\ current\ state \\
                \qquad t \in \{reachable\ from\ s\}
    \end{array}$


In any game we would start at a given state `s`, and then expand to all possible states `t`
and find the minimax value for each of the states, if the player is MAX the value would
be the maximum of all the children states, and if the player is MIN the value would be the
minimum of all the children states.

This means that for a simple game of tic-tac-toe we have 9 possibles moves for the first
player, MAX, then 8 possible moves for MIN, then 7 for MAX, and so on or 9! possible states we
could end up at (ignoring symmetry). 

## Mini-Max Algorithm

Below is the pseudo for the minimax relation defined above.
````python
# Pseudo Code
def minimax(s):    
    return moveWithValue(maxVal(s)) # Return the Best Max-Can do And move to Make



def minVal(s):
    if terminal(s):
        return utility(s)
    v = INFINITY
    for nextState in s.nextStates():
        v = min(v, maxVal(nextState))
    return v



def maxVal(s):
    if terminal(s):
        return utility(s)
    v = NEG_INFINITY
    for nextState in s.nextStates():
        v = max(v, minVal(nextState))
    return v      
````
<span style="font-size:small;">\*Algorithm derived from AIMA by Russell and Norvig\*</span>

While this algorithm might work well enough for a simple game, it is far from reasonable
for games with larger branching factors.

Some suggestions are to evaluate the utility of a state, in an depth-limited search fashion,
in which we could evaluate a state by some heuristic, or we can also prune the search space 
to reduce the time it takes to make a decision. Doing both might even work great for
games with very large branching factors. For now lets take a look at how we might be able to 
prune the search space.

*Note: Limiting the depth could be implemented by passing in a counter to each minVal and maxVal
function, and decrementing each time, when the counter reaches zero, then the game is evaluated for
its utility using another function that measures expected utility, rather then actual utility*

## MiniMax with Alpha-Beta Pruning

Alpha Beta Pruning is a method of pruning the search space after a particular area has been explored

Given that we know that Max and Min will always seek to move towards the state with the
best utility value for themselves, we can make use of the that information to prune 
the search space by reasoning about what position Max/Min will move to, given that we have
seen a better move that our opponent would make. So we can prune a particular area of the
search space, since we know opponent will not move to a particular branch because there is a 
better one already seen. 

To implement this, we need to keep track of two values, alpha: $\alpha$ and beta: $\beta$ which is where
this method gets its name. Alpha will be used to keep track of the best value that MIN could choose along a particular branch.
Likewise, beta will be used to keep track of the best value that MAX could choose along a particular branch.

> $\alpha \text{ is the best value we have so far for MAX} \\
\beta \text{ is the best value we have so far for MIN}$

The Alpha-Beta Minimax algorithm updates the values of alpha and beta as it goes along and 
branches are pruned whenever as soon as the current node is known to be worse than the current 
alpha or beta.



````python
def minimaxAlphaBeta(s):
    v = maxVal(s, NEG_INFINITY, INFINITY)
    return moveWithValue(v) # Return the Best Move Max can Make


def minVal(s, alpha, beta):
    if terminal(s):
        return utility(s)

    v = INFINITY
    for nextState in s.nextStates():
        v = max(v, maxVal(nextState, alpha, beta))
        
        if (v <= alpha):  # Prune Step
            return v 
        
        beta = min(beta, v)
    return v

def maxVal(s, alpha, beta):
    if terminal(s):
        return utility(s)

    v = NEG_INFINITY
    for nextState in s.nextStates():
        v = max(v, minVal(nextState, alpha, beta))
        
        if (v >= beta): # Prune Step
            return v 
        
        alpha = max(alpha, v)
    return v
````
<span style="font-size:small;">\*Algorithm derived from AIMA by Russell and Norvig\*</span>

## Conclusion

The Minimax algorithm with Alpha Beta pruning works for games with two players are presented
here, but there is a somewhat extreme that may keep this algorithm from being practical in 
that it depends on the ability to reach leaf nodes given a starting state. Because this is
a depth first search algorithm we are potentially exploring $O(b^d)$ nodes, so exploring 
heuristic minimax evaluation at cutt-offs and methods like iterative deepening search, and 
hashing explored states, and symmetric states helps adversarial minimax search become more
applicable to more complex games. 

A good representation of a game state, can go a long way in reducing running complexity, 
branching factor and helps to implement heuristics that will give accurate and fast results. 

## Related Resources
[Minimax](http://en.wikipedia.org/wiki/Minimax)<br>
[Alpha-Beta Pruning](http://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning)<br>
[Negamax](http://en.wikipedia.org/wiki/Negamax)<br>
[Probcut - Extension of the Alpha Beta Algorithm](http://wiki.cs.pdx.edu/cs542/papers/buro/probcut.pdf)<br>
[Adversarial Search](Puzzle://en.wikipedia.org/wiki/Eight_queens_puzzle)