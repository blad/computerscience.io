---
title: Topological Ordering of A Directed Graph
subtitle: Topological Ordering & Cycle Detection Algorithm
post: true
icon: molecule02
---

## Introduction
Graphs can be used to represent transitions from states, model a set of sequential requirements,
and various other relationships in the real-world. When dealing with topological ordering we 
are explicitly looking at graphs which are directed. 

When we have a graph we can determine a topological ordering, which means that there is an ordering 
for all vertices in a graph that for every edge, from v to w, v is earlier in the ordering through
w. 

Imagine we have a simple graph with 3 nodes, $a \rightarrow b \rightarrow c \rightarrow d$ the graph\'s topological 
ordering would be, $a,b,c,d$ since $a$ can only reach other nodes, by going through $b$, and be must be visited before $c$,
and finally to visit $d$, all other nodes must be visited before.

When we have a cycle in a graph, there is no way to determine which vertice in the cycle should come first. 

There is a theorem that states that, graphs that have no cycles are the same as graphs that can be topologically ordered.

So we can solve the problem of cycle detection and topological ordering using the same algorithm, since we can not have 
both a cycle and a topological ordering, and we can not have neither.

## Algorithm
The algorithm below returns a topological order given that there is one, otherwise it returns a cycle. Note that in the algorithm
below returns a tuple, this is to that in use, we can determine which of the two the algorithm returned.

````python
def topologicalOrder(graphG):
    count     = {} # Dictionary
    available = [] # List
    order     = [] # List

    for vertice in graphG:
        count[vertice] = vertice.incoming()
        if vertice.incoming() == 0:
            available.append(vetice)

    # Topological Ordering
    while !available.empty():
        v = available.pop()
        for w in v.outgoing():
            count[w] = count[w] - 1
            if count[w] == 0
                available.add(w)
            order.append(v)
        if available.empty():
            return ("Topological Order", order);

    # Cycle Detection
    cycleList = []
    nonZero   = []
    for vertice in graphG:
        if count[vertice] != 0
            nonZero.add(vertice)

    v = nonZero.pop()
    while v not in cycleList: # Exits when we get back to starting vertice
        cycleList.add(v)
        for w in v.incoming():
            if w in nonZero:
                v = w
    return ("Cycle", cycleList);
````

## Additional Resources & References
[Topological Ordering](http://en.wikipedia.org/wiki/Topological_sorting)  <br>
[Cycle Detection](http://en.wikipedia.org/wiki/Cycle_detection)
