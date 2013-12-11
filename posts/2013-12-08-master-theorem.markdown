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
the sub-problems, before combining them into a solution. 

The most common example of a divide and conquer algorithm is the *Merge Sort*
algorithm. The Merge Sort algorithm takes a collection, splits it into two 
sub-problems of roughly equal size and then solves the two sub-problems and recombines
them into a solution. 

The solving of the sub-problems is usually a recursive step and results in a 
recurrence when it comes to analyzing the run time of such algorithm.

When looking to analyze the run time of a divide and conquer algorithm, it is 
often the case that the running time is of the form: $T(n) = aT(n/b) + f(n^c log^d{n})$

where:

- $n$ is the size of the input
- $a$ is the number of sub-problems
- $b$ is the size of each sub-problem
- $c$ and $d$ are the exponents of any divide/merge step


## Merge Sort Recurrence

For example we can math the recurrence of the merge sort algorithm, $T(n) = 2T(n/2) + O(n)$
and match it to the following values:

$a = 2$<br>
$b = 2$<br>
$c = 1$<br>
$d = 0$<br>

## Master Theorem

The Master Theorem is simply a cookbook method that allows us to find a closed form for a recurrence.

The rules are as follows:

$log_b{a} > c$ then $T(n) = O (n^{log_b{a}})$  <br>
$log_b{a} = c$ then $T(n) = O (n^c {log}^{d+1}{n})$ <br>
$log_b{a} < c$ then $T(n) = O (n^c {log}^{d}{n})$ 

## Example

If we take the assignments we made to variables $a,b,c$ above, then we can simply use them in our 
Master Theorem and find the closed form of the recurrence.

Plugging into the left side we see that $log_2{2} = 1$ and $c = 1$ and that tells
us that $log_b{a} = c$, so our closed form is $T(n) = O (n^1 {log}^{0+1}_2{n})$ 
which simplifies to $T(n) = O(n log_2{n})$ which is in fact the running time of merge sort.
