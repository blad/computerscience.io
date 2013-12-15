---
title: Shortest Path Algorithms
subtitle: DAG Shortest Path, Dijkstra, and Bellman-Ford Algorithms
post: true
icon: chart08
---

## Introduction
In computer science one of the most common problems is
finding the shortest path from one location to another. If we represent the 
locations as nodes or the paths between nodes as edges in a graph then we can easily 
consider using techniques like Depth First Search or Breadth first search to explore a search space.

Given that this is common problem, there are algorithms
that give us the shortest path, with graphs that have different path properties.

Some variations of the shortest paths problem include:

1. Given a weighted graph and a starting and ending nodes, find the 
   shortest path between the two nodes.
2. Given that a weighted graph has a *single starting node* find a path to all
   possible destinations.
3. Compute the shortest path between all pairs of nodes in a given graph.

These are all variations that sound different, but if you take a second to 
consider the relationships we are solving, you will see that an
algorithm that solves a problem like in #1 above, can also solve the problem 
#2, and we can then extend that to solving problems of the third type.

For simplicity, we will assume that we are given a list of all nodes in the graph from the start.

## Directed Acyclic Graphs
A Directed Acyclic Graph is a graph where there are no cycles, no nodes can refer to previous nodes. In other words
nodes all point in one general directions.

### DAG Shortest Path Algorithm
````python
# Pseudo Code
def DAGShortestPath(graphG, start):
    distance = {}
    parent   = {}

    distance[start] = 0
    parent[start] = None
    for v in graphG:
        if v != start
            distance[v] = INFINITY

    topologicalOrder = topologicalOrder(graphG)
    for v in topologicalOrder:
        for u in v.destinations():
            if distance[v] + weight(v, u) < distance[u]:
                distance[u] = distance[v] + weight(v, u)
                parent[u] = v
        
````

The running time for the DAG Shortest Path Algorithm is $O(m + n)$ where $m=(number\ of\ edges)$ and $n = (number\ of \ nodes)$


##Dijkstra\'s Shortest Path Algorithm

Dijkstra\'s algorithm solves the shortest path problem for directed graphs with non-negative edge weights.

Dijkstra\'s algorithm partitions the set of nodes in a graph into two parts. The active list, which is a
set of nodes that do not yet have their incoming distances considered and the complete list
which is the set of nodes which have their correct distances calculated.

The algorithm makes the assumption that we will process nodes in our active list by increasing distance from 
a given starting point. So having negative edges violates that assumption, leading us to incorrect 
shortest paths. Therefore the algorithm does not work for graphs with negative edge weights.


### Dijkstra\'s Shortest Path Algorithm
````python
def DijkstrasShortestPath(graphG, start):
    distance = {}
    parent = {}
    complete = set()
    comparator = lamda x y: distance[x] < distance[y] # order by minimum distance
    active = priority_queue(comparator)

    distance[start] = 0
    parent[start] = None

    for v in graphG:
        distance[v] = INFINITY
        active.add(v)

    while !active.empty():
        v = active.dequeue()
        complete.add()
        for w in v.destinations():
            if active.contains(w) && distance[w] > distance[v] + weight(v, w):
                distance[w] = distance[v] + weight(v, w)
                parent[w] = v
````
Running time for Dijkstra\'s Algorithm is $O((n+m)log\,n)$ the algorithm like the DAG algorithm traverses all nodes
and edges, but also incurs a cost for ordering the nodes in a Priority Queue. The running time of the algorithm
is then affected by the data structure that is used to order the nodes in the active list.

##Bellman-Ford Shortest Path Algorithm
The Bellman-Ford Algorithm works with graphs that contain negative edge weights, but no
negative cycles.  The idea is that if we knew an ordering for the shortest path tree we could add one edge at a time
to form the shortest path, but since we do not know what the shortest path tree is, we try all the edges in the graph,
since we know one of the paths will be correct. 
````python
def bellmanFordShortestPath(graphG, start):
    distance = {}
    parent   = {}
    
    for v in graphG:
        distance[v] = INFINITY

    distance[start] = 0
    parent[start] = None

    for i in range(1, count(graphG.nodes())-1)
        for edge in graphG:
            if distance[edge.destination] > distance[edge.source] + edge.weight()
                distance[edge.destination] = distance[edge.source] + edge.weight()
                parent[edge.destination] = edge.source

````
The Bellman-Ford algorithm gives us a running time of $O(nm)$ since we are processing each
edge, n times. While this is a worse running time than the DAG and Dijkstra\'s algorithms, 
it does allow cycles (non-negative) and negative edge wights.

## Conclusion
Here is a table of the differences in the algorithms presented above. The applications of each algorithm
will be dictated by the graph\'s edge weights and whether or not there are cycles int he graph and what
type of cycles those are.

--------------------------------------------------------------------------------------------------------
Algorithm                   Cycles                      Edge Weights                     Running Time
--------------------------- --------------------------- -------------------------------- ---------------
DAG Algorithm               Not Allowed                 Any Value                        $O(n+m)$

Dijkstra\'s Algorithm       Allowed                     Non-Negative Only                $O((n+m)log\,n)$

Bellman-Ford Algorithm      Non Negative Cycles         Any Value                        $O(nm)$
--------------------------------------------------------------------------------------------------------

## Additional Resources
[Dijkstra\'s Algorithm - Wikipedia](http://en.wikipedia.org/wiki/Dijkstras_algorithm) <br>
[Bellman Ford Algorithm - Wikipedia](http://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm)<br>
[Directed Acyclic Graph - Wikipedia](http://en.wikipedia.org/wiki/Directed_acyclic_graph)