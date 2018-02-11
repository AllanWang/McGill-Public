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

# Bipartite Graph

* Undirected graph such that the vertices can be partitioned into X and Y such that all edges are between X and Y
* Does not have an odd cycle

## Largest Matching Problem

> Matching - set of edges such that no two of them share an endpoint
> Perfect Matching - matching that includes all the vertices

* Solving with max flow
    * Construct a flow network, with all edges directed from `X` to `Y`
    * Create two new vertices, `s`, and `t`
        * Add edges from `s` to every vertex in `X`
        * Add edges from every vertex in `Y` to `t`
    * Assign capacity 1 to all edges
    * Getting max flow will therefore solve for largest matching

> Vertex cover - set of vertices such that removing them will remove all the edges

* Theorem (K&ouml;nig) - in every bipartite graph, max matching = min vertex cover
    * To summarize, max-flow = min-cut = min-vertex-cover = min-cut

## Disjoint Paths

* Max-flow = # disjoint paths
    * For directed graph, can prove by using FF to find k, and finding k paths, removing it, and repeating (induction)
    * For undirected graph, split each edge into two going into either directions (now directed). Using FF, if it results in an edge with forward and backwards flow, the edges can be cancelled out so that the edge won't be used.

# Multi Source, Multi Sink Flow

* We may solve this by simply defining a new source s, which connects to all of the existing sources with an edge of capacity infinity. Same goes for sink.

# Baseball Elimination Problem

* Deciding if A is eliminated
    * Let M = max # of points A can collect after all the matches. <br>
      $M = P_A + deg(A)$ <br>
      Remove from graph.
    * For every remaining edge `uv`, put vertex `uv` in network (set `X`).
    * For every remaining team, add vertex (set `Y`).
    * Add source `s` and sink `t`.
    * Add edge with capacity 1 from `s` to each `uv`
    * Add edge with capacity &infin; from each `uv` to each `u` and `v`
    * Add edge with capacity $M - P_{self}$ from each `Y` to `t`
    * Solve for max-flow
        * If value = outgoing capacity of `s`, `A` is not eliminated

$$Cap(A, B) = \sum_{x \in T} (M - P_x) + \text{number of matches } xy \text{ with at least one of } x \text{ or } y \text{ not in } T = max-flow$$

# Linear Programming

* Special class of optimization problems: optimizing linear function over set of linear constraints

* A linear program has
    * A set of variables $x_1, ..., x_n$ that can take real values
    * A set of linear constraints of the form $\alpha_1 x_1 + \alpha_2 x_2 + ... \alpha_n + x_n = \beta$, where $\alpha_i \in \mathbb{R} \ \forall i \in 0 .. n$
    * Linear objective function that we want to minimize or maximize <br>
      $c_1 x_1 + c_2 x_2 + ... c_n + x_n$, where $c_i \in \mathbb{R} \ \forall i \in 0 .. n$ 
    * 