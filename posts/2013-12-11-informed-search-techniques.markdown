---
title: Heuristic Search Algorithms
subtitle: Exploring Best First, Greedy Best First, and A* Search Algorithms
post: true
date: 2013-12-11
icon: ruler-compasses
---

## Heuristics in Search Algorithms
Heuristics are basically guidelines which are used to help aid
decision making. Heuristics are used in informed search algorithms to help
us reach an optimal solution quicker than we would by exploring the entire 
search space.

## General Search Problem
When we consider a search or path problem, we generally compare our solution
with an evaluation function that tells us how good our solution is in comparison
to another solution, or partial solution, this is generally refered to as the 
*evaluation function* or *objective function* which we generally seek to minimize
in shortest/quickest path type problems.

$minimize:\ f(n)$

The heuristics in search algorithms come into play when we introduce problem 
specific knowledge beyond that given by a problem definition.

For example in a shortest path problem, we might use knowlege about the topography 
of the search space like straight line distance to help estimate an what the 
optimal solution could be and this help us reach that optimal solution.

For that we define two more functions in addition to $f(n)$.

$\begin{array} \\
  g(n) = Cost\ of\ Reaching\ a\ Node\ From\ Start \\
  h(n) = Estimated\ Cost\ to\ Goal\ Node \\
  \end{array}$

In an uninformed search algorithm our objective function would consist of just $g(n)$
and $f(n) = g(n)$ since we would not be taking into consideration anything other than the path cost 
so far.

Another way to potentially look at this is to have $f(n) = h(n)$ and choose the next node, by choosing 
the nodes that we think will get us to the goal sooner.

And lastly we can also consider using both as $f(n) = h(n) + g(n)$ where our objective function is
an *estimate* of the total cost to reach the goal. And thus, provides a much better estimate, if we use 
reasonable heuristics(estimates).

## Best First Search
If we consider the algorithm for the case where $f(n) = g(n)$ then our algorithm looks something like
below, where our objective function is just an ordering of the path costs and we explore nodes with lower 
path costs first. This is the same algorithm as Uniform Cost Search.
````python
#Pseudo Code
def BestFirstSeach(start, goal):
    objectiveFunction = lamda a b : return a.pathCost < b.pathCost  # g(n)
    frontier = priority_queue(objectiveFunction)
    frontier.add(start)

    explored = set()

    while not frontier.empty():
        node = frontier.pop()
        if node is goal:
            return solution(node)
        for neighbor in node.neighbors():
            if neighbor not in explored or frontier
                neightbor.parent = node
                frontier.push(neighbor)
            else if neighbor in frontier and neighbor.pathCost < inFrontier(neighbor).pathCost
                frontier.remove(neighbor) # With Higher Path Cost
                fontier.add(neighbor)     # Lower Path Cost
    return false
````
<span style="font-size:small;">*\*Algorithm adapted from AIMA by Peter Norvig*</span>

## Greedy Best First Search
Consider the case where our objective function is based soly on a chosen heuristic, $f(n) = h(n)$.
Our algorithm will choose to expand the next node with the closest distance to the goal. 

If you think about this, with some intuition we can see that moving to a node that is estimated closest to
a goal node will more likely get us to the goal quicker than a node with is not as close to the goal.

This algorithms is not fool proof and the heuristic can lead us to dead-ends and less than optimal solutions,
making Greedy Best First Seach not optimal(Solution can be optimal, but it is not a guarantee).

````python
#Pseudo Code
def heuristicValues(node):
    # Contains our problem specific values - external knowledge
    return heuristicValue(node)

def GreedyBestFirstSeach(start, goal):
    objectiveFunction = lamda a b : return heuristicValue(a) < heuristicValue(b)  # h(n) 
    # Rest of Algo is same
    frontier = priority_queue(objectiveFunction)
    frontier.add(start)

    explored = set()

    while not frontier.empty():
        node = frontier.pop()
        if node is goal:
            return solution(node)
        for neighbor in node.neighbors():
            if neighbor not in explored or frontier
                neightbor.parent = node
                frontier.push(neighbor)
            else if neighbor in frontier and neighbor.pathCost < inFrontier(neighbor).pathCost
                frontier.remove(neighbor) # With Higher Cost
                fontier.add(neighbor)     # Lower Cost
    return false
````


## A\* Search
Lastly, we have what is one of the most famous best first search algorithms which is complete and 
optimal. A* search is able to reach a solution node by making decisions base on the combined 
estimated total cost to reach a goal node, making our objective funcition the sum of the path cost so far
and the estimated distance to the goal.

$f(n) = g(n) + h(n)$

Using a graph search with a Priority Queue like we have been so far, we can code up the algorithm, by modyfing our 
comparator for our priority queue.

````python
#Pseudo Code
def estimate(node):
    # Contains our problem specific values - external knowledge
    return heuristicValue(node)

def GreedyBestFirstSeach(start, goal):
    objectiveFunction = lamda a b : return (estimate(a) + a.pathCost) < (estimate(b) + a.pathCost)
    # Rest of Algo is same
    frontier = priority_queue(objectiveFunction)
    frontier.add(start)

    explored = set()

    while not frontier.empty():
        node = frontier.pop()
        if node is goal:
            return solution(node)
        for neighbor in node.neighbors():
            if neighbor not in explored or frontier
                neightbor.parent = node
                frontier.push(neighbor)
            else if neighbor in frontier and neighbor.pathCost < inFrontier(neighbor).pathCost
                frontier.remove(neighbor) # With Higher Cost
                fontier.add(neighbor)     # Lower Cost
    return false
````
## Conclusion

From this we can see that a simple modification to the ordering of the node processing can make a 
large difference between the amount of time, and if we can reach an optimal solution.

## Related Resources
[Artifical Intelligence a Modern Approach](http://aima.cs.berkeley.edu/index.html)* <br>
[A* - Wikipedia](http://en.wikipedia.org/wiki/A*_search_algorithm)<br>
[Best First Seach - Wikipedia](http://en.wikipedia.org/wiki/Best-first_search)<br>
[Greedy Best First Search - Wikipedia](http://en.wikipedia.org/wiki/Best-first_search#Greedy_BFS)<br>
[Graph traversal - Wikipedia](http://en.wikipedia.org/wiki/Graph_traversal) <br>
[Tree Traversal - WIkipedia](http://en.wikipedia.org/wiki/Tree_traversal)<br>
