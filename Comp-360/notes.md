# Comp 360

The following aims to be a short summary of the topics learned in Comp 360, Winter 2018. For a more detailed set of lecture notes, see the one by [Julian Lore](https://github.com/julianlore/McGill-Resources/blob/master/COMP360/COMP360.pdf)

## Topics Covered

* Network Flows
* Linear Programming
* Midterm
* Linear Programming (again)
* NP-Completeness
* Approximation Algorithms
* Randomized Algorithms

## Max Flow Problem

* Flow network - directed graph s.t.
    * Every edge has capacity $\ge 0$
    * There is a source $s$ and a sink $t$ s.t. $s \ne t$
* Flow - function $f: E \rightarrow R^+$ such that<br>$R^+ = \{ x \in \mathbb{R} \mid x \ge 0 \}$
* Capacity condition - for all edges, $0 \le \text{ flow } \le \text{ capacity}$
* Conservation - for all nodes (apart from source and sink), flow inwards = flow outwards
* Residual graph from flow
    * For every edge with flow $f$ and capacity $c$, draw the same edge with value $c - f$ and the opposite edge (reverse direction) with value $f$. If the value is 0, ignore that edge.
* Ford-Fulkerson
    * Repeatedly find a valid path from source to sink and draw the residual graph, until no path can be found. The resulting flow will be the max flow.
    * See [Comp 251 Ref](https://www.allanwang.ca/notes/mcgill/comp251/3.php?scroll_to=lecture-13)
    * Running time is $O(Km^2)$, where $K$ is the largest capacity, $n$ is the number of vertices, and $m$ is the number of edges

> A cut in a flow network is a partition (A, B) of the vertices such that $s \in A$, $t \in B$

> Capacity of this cut is the sum of the capacities of edges going from A to B

//todo