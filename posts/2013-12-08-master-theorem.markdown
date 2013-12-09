---
title: Master Theorem
subtitle: A Way to Analyze Divide & Conquer Recurrences
post: true
date: 12-08-2013
icon: formula01
---


## Introduction
A divide and conquer algorithm is an algorithm that solves a problem by 
decomposing a problem into multiple parts (dividing) and then solving (conquering)
the subproblems, before combinign them into a solution. 

The most common example of a divide and conquer algorithm is the *Merge Sort*
algorithm. The Merge Sort algorithm takes a collection, splits it into two 
subproblems of roughly equal size and then solves the two subproblems and recombines
them into a solution. 

The solving of the subproblems is usually a recursive step and results in a 
recurrance when it comes to analyzing the run time of such algorithm.

When looking to analyze the runtime of a divide and conquer algorithm, it is 
often the case that the running time is of the form: $T(n) = aT(n/b) + f(n^c log^d{n})$

where:

- $n$ is the size of the input
- $a$ is the number of subproblems
- $b$ is the size of each subproblem
- $c$ and $d$ are the exponents of any devide/merge step


## Merge Sort Recurrance

For example we can math the recurrance of the merge sort algorithm, $T(n) = 2T(n/2) + O(n)$
and match it to the following values:

$a = 2$<br>
$b = 2$<br>
$c = 1$<br>
$d = 0$<br>

## Master Theorem

The Master Theorem is simply a cookbook method that allows us to find a closed form for a recurrance.

The rules are as follows:

$log_b{a} > c$ then $T(n) = O (n^{log_b{a}})$  <br>
$log_b{a} = c$ then $T(n) = O (n^c {log}^{d+1}{n})$ <br>
$log_b{a} < c$ then $T(n) = O (n^c {log}^{d}{n})$ 

## Example

If we take the assignments we made to variables $a,b,c$ above, then we can simply use them in our 
Master Theorem and find the closed form of the recurrance.

Plugging into the left side we see that $log_2{2} = 1$ and $c = 1$ and that tells
us that $log_b{a} = c$, so our closed form is $T(n) = O (n^1 {log}^{0+1}_2{n})$ 
which simplyfies to $T(n) = O(n log_2{n})$ which is infact the running time of merge sort.
