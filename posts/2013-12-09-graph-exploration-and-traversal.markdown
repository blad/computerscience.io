---
title: Graph Exploration
subtitle: A Look at Depth First and Breadth First Exploration
post: true
date: 12-09-2013
icon: chart-analysis
---

## Depth First Exploration
Depth first exploration of an graph can be done in $O(|E| + |V|)$ time where $|V| = Number of Vertices$
and $|E| = Number of Edges$.  At each vertice, we iterate through each edge, and for each edge not in the
reached set we explore recursively. So we visit each vertex once, and explore each edge once, in a directed graph.

### Depth First Exploration Algorithm

````python
# Pseudo Code
reached = {}    # Empty Set
def DepthFirstExploration(node):
    reached.add(node)
    for w in node.outgoing():   # w is destination node
        if w is not in reached
            DepthFirstSearch(w)
````

Note that this algorithm can get into a very deep recursion, and may get stuck in certains areas of a 
graph while exploring very large graphs.


## Breadth First Exploration

Breadth first exploration is also linear in time complexity $O(|E| + |V|)$ since the algorithm visits each
vertex at most once, and explores each edge once in a directed graph.

### Breadth First Exploration Algorithm

````python
# Pseudo Code
notExplored = Queue()
visited     = Set()

def BreadthFirstExploration(start):
    visited.add(start)
    notExplored.add(start)

    while notExplored is not empty:
        v = notExplored.pop()
        for w in v.outgoing()  # w is destination
            if w not in visited
                notExplored.add(w)
                visited.add(w)
````