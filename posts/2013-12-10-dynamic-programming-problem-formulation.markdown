---
title: Problem Solving with Dynamic Programming
post: true
date: 12-10-2013
icon: gears
---
## Introduction

Dynamic Programming is about solving a problem by taking it and then
decomposing it into smaller overlapping subproblems.

Dynamic Programming boild down to:

1. Finding a recurrance whose solution is the optimal value
2. Using an iterative solution to compute the values of the reccurance.

We do this to solve for the optimal solution of problem, since we know
that a problem will be composed of optimal solutions to its subproblems.

## Maximum Subarray Problem
Given a one dimensional array, amoung all contigous sub-arrays find the sub-array
with the max sum.


The recurrance has the form:

$S_i = \left\{
        \begin{array}\\
            A_0 & : |A| = 1 \\
            max(A_i, S_{i-1} + A_i) & : otherwise
        \end{array}
    \right.$

Where $S_i$ is the sum of the longest subsequence, recursively defined as the maximum of the 
$i^{th}$ element in array $A$ or the sum of the element $A_i$ and the previous largest sum.

And then we turn this into an code that computes the values of the reccurance iteratively.

````python
# Pseudo Code
def LargestContSubsequenceSum(array A):
    if len(A) == 0: return false;   # Handle empty array case.

    S = array[len(A)]
    S[0] = A[0]
    for 1 in [1..len(A)-1]:
        S[i] = max(S[i-1], S[i-1] + A[i-1])
    return maximum(S)  # Return maximum value in S
````
So this is great, we calculated the max sums of contigious sub-arrays, but how do we know
which is the sub-array with the greatest sum? Well since we calculated the array `S` we can
modify the algorithm above to do a bit of book keeping keep track of the starting index of the
current sum of a sub-array.

````python
#Pseudo Code
def maxSumSubArray():
    S = array[]
    Y = array[]             # New array to track indecies

    S[0] = A[0]
    Y[0] = 0                # first sum 0 starts at 0
    for i in [1..len(A)-1]:
        if A[i] > S[i-1] + A[i]:
            X[i] = A[i]
            Y[i] = i        # Current Largest Starts at index i
        else
            S[i] = A[i] + S[i+1]
            Y[i] = Y[x-1]   # Current sum started at sane index as previous

    end = indexOfMaximumSum(X)
    start = Y[end]            # Y[end]  contains the start index of that sum.
    return A[start:end]       # return the sub array from `start` to `end`
`````
## Fibonnacci Numbers
Fibonacci Numbers are defined by the following reccurrance;

$F_i = \left\{
     \begin{array} \\
       0  & : if i = 0 \\
       1 & : if i = 1 \\
       F_{i-1} + F_{i-2} & : otherwise
     \end{array}
   \right.$

We can then turn this recurrance directly into an algorithm to find the $i^{th}$ Fibonacci number as follows;

````python
#Pseudo Code
def generateFib(n):
    F = array[n]
    F[0] = 0
    F[1] = 1
    for 2 in range(0, n):
        F[i] = F[i-1] + F[i-2]
    return F


def fib(n):
    F = generateFib(n) # Build a table of fib numbers.
    return F[n] # Do a Table look Up.
````

This dynamic programming solution uses $O(n)$ space, and generates the table in $O(n)$ time as well.

Once the table is built, the query of the $n^{th}$ fibonacci number is $O(1)$ assuming values up to $n$
have already been generated and captured elsewhere.


## Longest Common Subsequence of Two Strings
Given two sequences of strings, find the *longest* common
subsequence of characters.

We can solve this by looking at the ends of the two strings, we do this
because we can easily see that the longest common subsequence of both strings will match
contain a this match at the end.

If the ends of the strings do not match then we must discard one of the characters in one
of the two substrings, in which case we are back at the original problem of finding the 
longest common substring, but we are now looking at a subproblem of the original, which has
the same solution as that of the larger problem. 

We can then find the solution for the subproblems of using a prefix of the first string and 
a prefix of the second string, and use the best solution from the two subproblems.

We derive a recurrance to break down our problem to subproblems.


$L_{i,\ j} = \left\{
     \begin{array} \\
       L_{i-1,\ j-1} + 1 & : if last\ characters\ match \\
       max (L_{i-1,\ j}, L_{i,\ j-1}) & : otherwise
     \end{array}
   \right.$

Having determined a reccurance, we can now translate this into building a table of values we can 
then turn around and look up.

````python
# Pseudo Code
L = array[len(X)+1, len(Y) +1]

def LCSLength(String X,String Y)
    for i in range(0, length(X))
        for i in range(0, length(Y))
            if i == 0 or j == 0
                L[i,j] = 0
            else if X[i-1] == Y[j-1]
                L[i, j] = L[i-1, j-1] + 1
            else
                L[i, j] = max(L[i-1, j], L[i, j-1])
    return L[len(X), len(Y)]
````

This algorithm gives us the maximum length of our longest common subsequence, but now we can use the table
that we generated to backtrack using the table and extract the longest common subsequence.

````python
# Pseudo Code
def GetLCS(X, Y):
    i = len(X)
    j = len(Y)
    out = Stack()
    while i > 0 or j > 0:
        if X[i-1] == Y[j-1]:
            out.add(X[i-1])
            i--
            j--
        else if L[i,j-1] >= L[i-1, j] # Move to Best Subproblem Solution
            j -= 1
        else
            i -= 1
    
    # Pop elements off the stack to display in order from start to end
    return out
````

## 0-1 Knapsack Problem

The Knapsack problem is one of the most famous optimization problems in computer 
science. The whole problem boils down to having a set of **items** with two types of properties, 
a **value** and a **weight**, and a knapsack that has a limited **capacity**. 

The goal is to maximize the value of the set of items you take, without going over the capacity
constraint which is only affected by the weight.

$\begin{array} \\
    maximize: & \sum_{i=0}^{n}{v_i}\\
    \\
    such\ that: & \sum_{i=0}^{n}{w_i} \le C \\
\end{array}
$

$v$ is an array that holds values, where each index, $v_i$ corresponds to the value of item $i$.

$w$ is an array that holds weight, where each index, $w_i$ corresponds to the weight of item $i$.

$C$ is the overall capacity contraint of our knapsack.

So the idea is to choose a subset of the items whose sum of weights is less than our capacity constraint
and whos value is as large as possible. To use an analogy, imagine being in a cave with treasure
and being able to only carry 50 pounds, but you know everything has a different worth {a.k.a. benefit/profit}
you can derive, so you must pack your knapsack such that you can carry it and achieve maximum profit.


To make this a dynamic programming problem we must find a reccurrance. 
$K_{i,\ j} = \left\{
     \begin{array} \\
       0 & : if\ i = 0 \\
       K_{i-1,\ j} & : if\ w_{i-1} > j \\
       max (K_{i-1,\ j}, (K_{i-1,\ j-w_{i-1}} + v_{i-1})) & : otherwise
     \end{array}
   \right.$

In our recurrance, $K_{i,\ j}$ is the benefit we get from considering the first $i$ items and capacity
$j$. 

Imagine having a knapsack, starting with 50 pounds, after taking item $n$ of weight 5 and value 10, we 
can then solve the equivalent subproblem of a 45 pound knapsack and with $n-1$ items, or the subproblem of
a 50 pound knapsack with $n-1$ items. Meaning we either take item $n$ or we do not. The optimal solution 
will then be a a set containing the optimum solution to each of the sub problems.


Traslating the recurrance into code we get:
```python
# Pseudo Code
def KnapsackBuildRecurrance(C:Capacity, sizes:array, values:array)
    K = array[n,C]  # Two-dimensional array
    for i in range(0,n):
        if i == 0:
            K[i,j] = 0
        else if size[i-1] > j
            K[i,j] = K[i -1, j]
        else
            K[i, j] = max(K[i-1, j], K[i-1, j-weight[i-1]] + values[i-1])
    return K
# Optimal Value is K[x, y] where x is number of items and y is knapsack size we are considering
````

After computing the table values for our knapsack problem we can then use a similar algorithm 
to the Longest Common Subsequence algorithm retreive the set of items that we choose to take.

## Analysis
Dynamic programming is simply filling in an array when it computes the values of a reccurrance, so the
running time of a dynamic programming is $O(nm)$ where $n$ and $m$ are the dimentions of the array
we are filling out, where the worst case comes when $n = m$ thus $O(n^2)$ worst case time in the number of input items.

## Additional Resources
[Ch6 Dynamic Progamming- S. Dasgupta, C. H. Papadimitriou, and U. V. Vazirani](http://www.cs.berkeley.edu/~vazirani/algorithms/chap6.pdf)<br>
[Dynamic Programming - Wikipedia](http://en.wikipedia.org/wiki/Dynamic_programming)<br>
[Knapsack Problem - Wikipedia](http://en.wikipedia.org/wiki/Knapsack_problem)<br>
[Pseudo Polynomial Time - Wikipedia](http://en.wikipedia.org/wiki/Pseudo-polynomial_time)<br>
[Longest Common Subsequence - Wikipedia](http://en.wikipedia.org/wiki/Longest_common_subsequence_problem)<br>
[Subset Sum Problem - Wikipedia](http://en.wikipedia.org/wiki/Subset_sum_problem)<br>
[Fibonacci Number - Wikipedia](http://en.wikipedia.org/wiki/Fibonacci_number)<br>