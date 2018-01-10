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

> A flow network is a directed graph $G = (V, E)$ st
> 1. Every edge e has a capacity $c_e \le 0$
> 1. There is a source $s \in V$
> 1. There is a sink $t \in V$ such that $t \ne s$

For convenience, we will also assume that

1. No edge enters the source
1. No edge leaves the sink
1. All capacities are integers
1. There is at least one edge incident to every vertex

> A flow is a function $f: E \rightarrow R^+$ such that
> $R^+ = \{ x \in R \mid x \ge 0 \}$

| | | |
|---|---|---|
| Capacity Condition | $\forall e \in E$ | $0 \le f(c) \le c_e$ |
| Conservation | $\forall u \in V \setminus \{s, t\}$ | $\sum\limits_{vu \in E} f(vu) = \sum\limits_{uw \in E} f(uw)$


* Capacity Condition - amount of flow for every edge is &le; max flow allotted
* Conservation Condition - flow entering a vertex = flow exiting that vertexes (ignoring source & sink)

# Lecture 2 - 2018/01/10

## Max Flow Problem

> Given a flow network, find the maximum legal value of flow

### Ford-Fulkerson Algorithm

[Comp 251 Ref](https://www.allanwang.ca/notes/mcgill/comp251/3.php?scroll_to=lecture-13)

* Try to find s-t maths that have not used their capacity & push more flow through them
* Subtlety: not all path sequences picked will lead to an optimal flow. We will resolve this by considering backwards flow.

#### Residual Graph

> Given a flow network (G, s, t, {c<sub>e</sub>}) and a flow f on G, the residual graph $G_f$ is as follows:

1. Nodes are the same as G
2. For every edge $uv \in G$ with $f(uv) < c_{uv}$, add the edge $uv$ with residual capacity $c_{uv} - f(uv)$ to $G_f$
3. For every edge $uv \in G$ with $f(uv) > 0$, add the opposite edge $vu$ with residual capacity $f(uv)$

#### Validation

Claim: FF always reduces to a valid flow

Proof:

* Flow greater than capacity will never be assigned; capacity condition is satisfied
* When updating a node with a forward input and output, both paths will be increased by &alpha;. When updating a node with a backward input and output, both paths will be decreased by &alpha;. When updating a node with two inputs, the forward input will be increased by &alpha; and the backwards input will be increased by &alpha; In all cases, the net increase is 0, so the conservation condition is satisfied.

Claim: FF terminates

* The sum of all the edges is finite, so it has to terminate at some point

Running Time

* Let K be the largest capacity, n be the number of vertices, m be the number of edges.
* At most Km iterations
* Each iteration requires a DFS & augmentation $\leftarrow O(m + n)$
    * Since we assume that every node is connected by at least one edge, we know that $m \ge n/2$. So in reality, it is $O(m)$
* Total running time = $O(Km^2)$

> A cut in a flow network is a partition (A, B) of the vertices such that $s \in A$, $t \in B$

> Capacity of this cut is the sum of the capacities of edges going from A to B

A network with n vertices has $2^{n-2}$ (s, t)-cuts
<br>&emsp;((n - 2) vertices each has two choices)