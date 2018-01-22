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
    * Running time is $O(Km^2)$, where $K$ is the largest capacity, $m$ is the number of edges. We are assuming that the graph connected.
    * Max flow = min cut

> A cut in a flow network is a partition (A, B) of the vertices such that $s \in A$, $t \in B$

> Capacity of this cut is the sum of the capacities of edges going from A to B

* Faster Ford Fulkerson
    * Pick shortest path (use BFS instead of DFS)
        * Easy to implement, hard to analyze
    * Pick fattest path (augmenting path with largest bottleneck)
        * Hard to implement, easy to analyze
    * Scaling Ford Fulkerson
        * Set some $\Delta = 2^{\lceil log_2 K \rceil}$
        * While there exists an augmenting path with bottleneck $\ge \Delta$, augment with that path - runtime $3 * O(m)$ for checking, augmenting, updating
            * To find such a path, simply ignore all paths whose capacity $< \Delta$
        * If no such path exists, set $\Delta \leftarrow \frac{\Delta}{2}$ and repeat; end when $\Delta < 1$ - runtime $O(logK)$