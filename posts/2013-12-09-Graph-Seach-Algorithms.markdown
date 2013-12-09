---
title: Graph Searching Algorithms
subtitle: A Quick Exploration of Graph Searching Algorithms
post: true
date: 12-09-2013
icon: molecule05
---


## Introduction
A graph and a tree are simply two representations of a data-structure that we can 
consider as part of a problem. Some of the most common problems that we are looking
to solve that utilize these strucutres are shortest-path, least number of hops,
and even decision problems. In this post we will be looking at how we can search
a graph data strucure to get to a known goal node.

## Graph And Tree Search

In Peter Norvig\'s book, *Artificial Intelligence a Modern Approach*, Norvig makes a distinction
between two types of searchin algorithms, one he calls `Tree Search` and the other `Graph Search`,
where both algorithms work on graphs and trees, regardless of their names.

The distinction in these two algorithms comes in the fact that `Tree Search` is simply
search that has no memory of previously explored nodes, and is analogous to searching a Tree,
where all nodes have children and there are no references back up to a parent node.

While `Tree Search` works great for well, trees, it can also be used on graphs, but the
consequence is that we are then able to revisit nodes we visited previously, if there happens to
be a cycle in our graph.

The algorithms are presented in pseudo code below, and are modified version of those that
Norvig presents in his AIMA book.

After that we look at the various algorithms based on `Graph Search` that we can use to find
a path from a starting node to a desitination or goal.

### Tree Search Algorithm

The Tree Search Algorithm uses a FIFO Queue to keep track of the nodes we still need to explore,
It then looks at the neighbors (Children) of each node starting at a start (root) node,  and
continueing until a solution is found. 

```python
def TreeSearch(start, goal):
    frontier = fifo_queue()

    frontier.push(start)
    for neighbor in start.neighbors():
        frontier.push(neighbor)

    while not frontier.empty():
        node = frontier.pop()
        if node is goal:
            return solution(node)
        for neighbor in node.neighbors():
                neighbor.push(frontier)
    return false
````
*\*Algorithm adapted from AIMA by Peter Norvig*

Note that in this tree algorithm, if our graph has cycles, it is possible that our tree will be
visit the node it came from in a future iteration.

### Graph Search Algorithm
````python
# Pseduo-Code
def GraphSearch(start, goal):
    explored = set()
    frontier = fifo_queue()

    frontier.push(start)
    for neighbor in start.neighbors():
        frontier.push(neighbor)

    while not frontier.empty():
        node = frontier.pop()
        explored.add(node)
        if node is goal:
           return solution(node)
        for neighbor in node.neighbors():
            if neighbor not in explored && neighbor not in frontier:
                neighbor.push(frontier)

    return false
````
*\*Algorithm adapted from AIMA by Peter Norvig*

Note that the Graph Search Algorithm is remembering the nodes that it has been to and is
keeps exploring outward into the search space, not revisiting nodes it has been to before.

## Depth First Search
````python
#Pseudo Code
def DepthFirstSearch(start, goal):
    frontier = lifo_queue()
    frontier.add(start)

    while not frontier.empty():
        node = frontier.pop()
        if node is goal:
            return solution(node)
        for neighbor in node.neighbors():
            if neighbor not in frontier
                neightbor.parent = node
                frontier.push(neighbor)
    return false
````
*\*Algorithm adapted from AIMA by Peter Norvig*

DFS Algorithm uses $O(bm)$ space, where $m$ is the maximum depth that is explored, this is because
we are no longer remembering what nodes we have explored, since we are exploring as deep as possible.
 This algorithm essentially remembers a single path from the root of the tree to the a single leaf
node. While it still able to explore the entire tree in worst case $O(b^m)$ time.


## Breadth First Search
````python
# Pseduo-Code
def BFS(start, goal):
    explored = set()
    frontier = fifo_queue()

    frontier.push(start)

    while not frontier.empty():
        node = frontier.pop()
        explored.add(node)
        for neighbor in node.neighbors():
            if neighbor not in explored && neighbor not in frontier:
              if node is goal: return solution(node)
              neighbor.push(frontier)
````
Total Nodes Generated: $O(b^d)$ and Since we are remembering all the nodes that
have been explored, then we have a space complexity of $O(b^d)$


## Uniform Cost Search
````python
#Pseudo Code
def UCS(start, goal):
    comparator = lamda a b : return a.pathCost < b.pathCost
    frontier = priority_queue(comparator)
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
*\*Algorithm adapted from AIMA by Peter Norvig*

The Uniform Cost Search Is going to explore $O(b^{d+1})$ since it is expanding each of the child nodes 
before testing for success, thus exploring one level more than the required depth. In addition, 
we are remembering all the nodes that we have explored so far in our `explored` set.


## Depth Limited Graph Search
````python
# Pseudo Code
def DepthLimitedSearch(start, goal, limit):
    node = start
    if node is goal
        return node                     # We reached our goal node.  
    else if limit = 0
        return CUTOFF_REACHED           # Constant-Indicates Cotoff Reached Failure
    else
        cutoff = false
        for neighbor in node:
            result = DepthLimitedSearch(node, goal, limit - 1)
            if result is CUTOFF_REACHED   # We Reached a Cutoff Point
                cutoff = true
            else if result not false      # No Solution was Found within Limit
                return solution(result)
        
        if cutoff:
            return CUTOFF_REACHED
        else:
            return false
````

Depth Limited Seach has a time complexity of $O(b^l)$ and a space complexity of $O(bl)$.
Depth Limited Search is a way to do a depth-first style search without the possibility of
the algorithm getting stuck in one region of the search space, while giving us the space complexity
benefit of Depth First Search. The exception being that we much be careful to choose an
appropriate value fo r our limit, since our search must be within the limit otherwise we 
the search will not yield a solution.

## Iterative Deepening Graph Search
````python
def IterativeDeepeningSearch(start, goal):
    i = 0
    while True:
        result = DepthLimitedSearch(start, goal, i)
        if result not CUTOFF_REACHED
            return solution(result)
        i++
````

## Time & Space Analysis of Traversal Algorithms

Completeness tells us if the algorithm is *guaranteed* to find the a solution<br>
Optimality tells us if the algorithm is going to find the *optimum* solution<br>
Time Complexity tell us the worst case number of nodes that will be explored.<br>
Space complexity tell us what the worst case number of nodes that will be remembered at a time.

--------------------------  ---------------     ---------------    ----------------    -----------------
Algorithm                   Completeness        Optimality         Time Complexity     Space Complexity
--------------------------  ---------------     ---------------    ----------------    -----------------
Breath First Search         Yes                 Only For Equal     $O(b^d)$            $O(b^d)$
                                                Step Costs             

Depth First Search          No                  No                 $O(b^m)$            $O(bm)$

Uniform Cost Search         Only if path cost   Yes                $O(b^{d+1})$        $O(b^{d+1})$
                            are positive and
                            non-zero

Depth Limited Search        No                  No                 $O(b^{l})$          $O(bl)$

Iterative Deepening Search  Yes                 Only For Equal     $O(b^{m})$          $O(bm)$
                                                Step Costs
--------------------------  ---------------     ---------------    ----------------    -----------------
\* Table Can be found in AIMA by Peter Norvig p.91

## Additional Reading & References
[Artifical Intelligence a Modern Approach](http://aima.cs.berkeley.edu/index.html)* <br>
[Graph traversal - Wikipedia](http://en.wikipedia.org/wiki/Graph_traversal) <br>
[Tree Traversal - WIkipedia](http://en.wikipedia.org/wiki/Tree_traversal)<br>
