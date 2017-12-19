# Comp 360

# Lecture 1 - 2018/01/08

Did some practice questions to look at notation.

## Topics Covered

* Network Flows
* Linear Programming
* Midterm
* Linear  Programming
* NP-Completeness
* Approximation Algorithms
* Randomized Algorithms

## Max Flow Problem

> A flow network is a directed graph G = (V, E) st
> 1. Every edge e has a capacity c<sub>e</sub> &le; 0
> 1. There is a source s &isin; V
> 1. There is a sink t &isin; V such that t &ne; s

For convenience, we will also assume that

1. No edge enters the source
1. No edge leaves the sink
1. All capacities are integers
1. There is at least one edge incident to every vertex

> A flow is a function f: E &rightarrow; R<sup>+</sup> st
> R<sup>+</sup> = { x &isin; R | x &ge; 0 }

| | | |
|---|---|---|
| Capacity Condition | &forall;e &isin; E| 0 &le; f(c) &le; c<sub>e</sub> |
| Conservation | &forall;u &isin; V \ {s, t} | &Sigma;(vu &isin; E) f(vu) = $\sum\limits_{uw \isin E} f(uw)$


* Capacity Condition - amount of flow for every edge is &le; max flow allotted
* Conservation Condition - flow entering a vertex = flow exising that vertexs (ignoring source & sink)