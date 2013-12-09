---
title: Problem Solving with Dynamic Programming
post: true
date: 12-10-2013
icon: gears
---

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

## Knapsack Problem

$K_{i,\ j} = \left\{
     \begin{array} \\
       0 & : if i = 0 \\
       K_{i-1,\ j} & : if s_{i-1} > j \\
       max (K_{i-1,\ j}, (K_{i-1,\ j-1} + v_{i-1})) & : otherwise
     \end{array}
   \right.$

Traslating the recurrance into code we get:
```python
# Pseudo Code
def KnapsackBuildRecurrance(C:Capacity, sizes:array, values:array)
    K = array[n,C] 
    for i in range(0,n):
        if i == 0:
            K[i,j] = 0
        else if size[i-1] > j
            K[i,j] = K[i -1, j]
        else
            K[i, j] = max(K[i-1, j], K[i-1, j-1] + values[i-1])
    return K

# Optimal Value is K[x, y] where x is number of items and y is knapsack size.
````
