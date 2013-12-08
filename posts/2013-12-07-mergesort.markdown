---
title: A Look at Merge Sort
subtitle: A Look At Comparison Based Sorting Algorithms
post: true
date: 12-07-2013
---


#Introduction
Imagine we are looking at an unordered collection of items that have some sort
of ordering.

For example: `integers`, `rational numbers`, `characters`, `string` all have a
possible ordering. And we might have a collection such as `1,3,2,4,10` or `'z','c','b','a'`
or `"xyz", "acb", "cba", "abc"`

If we think about the way we naturally do ordering then we can easily see that 
to sort an collection of items, by selecting two items at a time and then making
a comparison between the two to determine order. After determining order, we make
a swap or and do this again with a distict pair of items in our collection, until
we have a sorted collection.

If we wanted to do this, there are several ways we can go about making the selection
and splitting up the collection in such a way that we can make certain assumptions 
about the contents of certain portions of the collection.

# Merge Sort
Merge sort is a Divide & Conquer Algorithm that divides the collection into two
roughly equal subproblems, sorts those subproblems recursively using the mergesort
algorithm and then combines each subproblem after a mergesort step.

So mergesort is split up into a split, sort, merge steps, with each sort step being a 
recursive call.

## Algorithm
````python
# Pseudo Code
def mergeSort(collection):
    if len(collection) < 2:
        return collection
    (half1, half2) = split(collection)
    sortedHalf1 = mergeSort(half1)
    sortedHalf2 = mergeSort(half2)
    return merge(sortedHalf1,sortedHalf2)
````

### The Split Step

The split step, simply divides the collection into two portions, so simply doing

````python
#Pseduo Code
def split(collection):
    start   = 0
    halfWay = len(collection) / 2   # Assumming Integer Division
    end     = len(collection) - 1   # Sub 1 for 0 Indexed Array
    return (collection[start, halfWay], collection[halfWay+1, end]) # Return 2 Lists
````


### The Merge Step

The merge step is the most important one, since it is what takes our two 
sublists, and puts then in order. It does this by making the assumptions that 
all elements in each sublist themselves are sorted. Starting at the front 
(0-index) of each list, it makes a comparison of each item, and places the each
element that comes first in order, after it has choosen one element over another, 
it moves on to the next element in the list. It does this until one list is empty. 

When one list becomes empty we know the remaining elements the other list are 
all greater than the last element in the first list, so we can just append the 
items in the second list to the result.

````python
# Pseudo Code
def merge(sortedList1, sortedList2):
    result = array[len(sortedList1) + len(sortedList2)]
    i = j = 0
    while i < len(sortedList1) and j < len(sortedList2):
      if sortedList1[i]  < sortedList2[j]
          result[i + j] = sortedList1[i]
          i++
      else
          result[i + j] = sortedList2[j]
          j++

    while i < length(sortedList1):
          result[i + j] = sortedList1[i]
          i++

    while j < length(sortedList2):
          result[i + j] = sortedList2[i]
          i++

    return result   # Sorted Sub-Array
````

## Merge Sort Running Time

> The analysis of merge sort boils down to worst case $O(n)=log n$. 

Each call to `mergeSort` generates, $O(1)$ work for the split step, $O(len(collection)) = O(n)$ 
for the merge step, and $2T(n/2)$ where T is a worst case time for the 
recursive call to two of the subproblems of size 2.

Resulting in a total:
$T(n) = 2T(n/2) + O(n) + O(1)$, which is recursive definition.

If we unroll the recursion, for a problem of size n, we can build a tree of 
the recursive calls that happen. We see that the comparisons (merge step) happens
after returning from the base case which happens at level $log_2{n}$, at that 
point the recursion starts walking back up the tree, and the merge step takes place 
at each parent node a total of $length(child1) + length(child2)$ times, with a 
total of $n$ times. 

Giving us a total time complexity of $O(nlogn)$

## Additional Reading & References

- [Sorting Algorithms: Merge Sort](http://www.sorting-algorithms.com/merge-sort)
- [Merge Sort Applet Animation](http://www.yorku.ca/sychen/research/sorting/index.html)
- [Wikipedia: Merge Sort](http://en.wikipedia.org/wiki/Merge_sort)



