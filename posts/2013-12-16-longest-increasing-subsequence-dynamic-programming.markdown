---
title: Longest Increasing Sub-sequence
subtitle: A Dynamic Programming Solution
post: true
icon: laptop02
---

## The Problem
The problem has a very simple in its description, and is typically just the following:


> Given a list of elements, find the longest increasing subsequence.

This post will describe the dynamic programming solution which runs in
approximately $O(n^2)$ time, and hint at the more optimal $O(nlogn)$ 
solution.

## Decomposing the Problem

In order to solve this problem via dynamic programming we must identify a 
pattern such that our optimal solution is based on a composition of optimal
subproblems.

Imagine we have the following sequence of 10 numbers, which were chosen arbitrarily;

> $1, 2, 1, 10, 20, 4, 5, 3, 2, 8$

In order to find the optimal solution, the longest sub-sequence of increasing numbers 
we can see that **if** our solution includes the last number, $8$, then our optimal 
solution must contain the longest sub-sequence of numbers from the first 9 elements, but
only if the last number of the sub-sequence is less than $8$. Otherwise, the optimal solution
would not include 8.

So we need to build a list of elements such that given an ending position, we can determine 
the size of the optimal sub-sequence ending at that number. After we build this list, we can
then just take the maximum element of this list, which would indicate the ending position and
length of our longest increasing sub-sequence.

> $maximum \{D_i\}\; \forall i \in [0..(|S|-1)], S = \{Given\ Sequence\}$

We will be doing this in a bottom-up manner, where we build
an array of keys and values, where keys will be ending positions to our subsequence, and 
values the length of the optimal subsequence including the number at that index.

## Algorithm
````python
# Pseudo Code
maxLength = 1 # Lower Bound
bestEnd    = 0 # Stating index 0
D[0]       = 1 # Base Sub-Problem

for (i in range(1, len(list))): # For all elements in the list
    D[i] = 1   # Base-Case for all subproblems, minimum length of 1.

    # Look at the subproblems ending at index i-1 to 0
    for (j = i - 1, j >= 0, j--):   
        # Make sure that our sub-problem size is better, and our elements are in increasing order
        if (D[j] + 1 > D[i] && array[j] < array[i])
            DP[i] = DP[j] + 1 # Include element at index i
    
    # Update the ending position of the best answer, and the size of the best answer
    # Or do a call to maximum() function after the loop is done, but this helps us keep track
    #  while the algorithm is in swing.
    if (DP[i] > maxLength):
        bestEnd = i
        maxLength = DP[i]
````
<p style="font-size:small">
**Algorithm Adapted from <a href="http://stackoverflow.com/questions/2631726/how-to-determine-the-longest-increasing-subsequence-using-dynamic-programming">Petar Minchev\'s answer on Stackoverflow</a>.
</p>

## Walk-Through the Algorithm
We start out by setting our base-case for element 0, then we loop through the remaining elements
at each step, we set the base-case for each element to a base value of 1. We then look at the sub-problems
that came before element `i`. We start at element `i-1`, and move down to 0, at each step, we determine most importantly if 
element `i` is in increasing order, and secondly, if the subproblem ending at some position `j`, leading up to `i`, is better than 
our current best solution ending at `i`.

If we step through this, you will see that the algorithm will update the value of `D[i]` any time we have a longer sub-problem,
as long as we are in increasing order from the ending position of that sub-problem.

While we might have an optimal solution ending at position `i`, it does not mean that the optimal solution ends at position `i`,
and the last if-statement in the loop is used to keep track of a global optimum as we build our subproblems for all the elements in the 
given list.

Finding the length of the optimum solution would then be found in the variable `maxLength`, and  `bestEnd` would contain the ending 
of position of the longest increasing subsequence.

## Finding The Longest Increasing Sub-Sequence
If you ran the algorithm above you would notice that you would be able to extract a length and a position, but not the elements themselves.

In order to find the elements, we add a additional variable, `P`, to keep track of the elements, that precede each other in the 
solution.

````python
# Pseudo Code
maxLength  = 1 # Lower Bound
bestEnd    = 0 # Stating index 0
D[0]       = 1 # Base Sub-Problem
P[0]       = None

for (i in range(1, len(list))): # For all elements in the list
    D[i] = 1   # Base-Case for all subproblems, minimum length of 1.
    P[i] = None # No Predecessor, all alone before looking at sub-problems

    # Look at the subproblems ending at index i-1 to 0
    for (j = i - 1, j >= 0, j--):   
        # Make sure that our sub-problem size is better, and our elements are in increasing order
        if (D[j] + 1 > D[i] && array[j] < array[i])
            DP[i] = DP[j] + 1 # Include element at index i
            P[i] = j          # Element at position j precedes sub-sequence ending at i.
    
    # Update the ending position of the best answer, and the size of the best answer
    # Or do a call to maximum() function after the loop is done, but this helps us keep track
    #  while the algorithm is in swing.
    if (DP[i] > maxLength):
        bestEnd = i
        maxLength = DP[i]
````
<p style="font-size:small">
**Algorithm Adapted from <a href="http://stackoverflow.com/questions/2631726/how-to-determine-the-longest-increasing-subsequence-using-dynamic-programming">Petar Minchev\'s answer on Stackoverflow</a>.
</p>

Now to extract the longest increasing sub-sequence we can simply backtrack through `P[i]` until we reach a value of `None` or some other 
ending indicator.

## More Optimal Solution
[Wikipedia](http://en.wikipedia.org/wiki/Longest_increasing_subsequence) has an article dedicated to this problem alone, and in it there is a short discussion of a more efficient algorithm
that runs in $O(nlogn)$ time. The algorithm maintains a sorted list of a number of values it has seen and does a number of binary searches to
find the length and the elements of the longest increasing sub-sequence. At each iteration it either adds a new number to the end of the
list, increasing the size of the longest common sub-sequence, or it updates a list of values seen.


## Conclusion
The reason I wrote this post, was to build a bit more intuition about dynamic programming and breaking down problems, into subproblems. I must admit, I struggled with
this problem for longer than I would have liked. My thanks go our to people like *Petar Minchev*, and the countless other who contribute their knowledge to the
programmer community.

## Additional Resources
[Petar Minchev - Explains on Stack Overflow](http://stackoverflow.com/questions/2631726/how-to-determine-the-longest-increasing-subsequence-using-dynamic-programming)<br>
[Longest Increasing Subsequence - Wikipedia](http://en.wikipedia.org/wiki/Longest_increasing_subsequence)

