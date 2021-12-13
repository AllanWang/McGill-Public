# Comp 251

> Jérôme Waldispühl &bull; [Course Webpage](https://www.cs.mcgill.ca/~jeromew/comp251.html) &bull; [Online Forum](https://osqa.cs.mcgill.ca/) &bull; [Algorithm Sorting Practice Questions](https://www.allanwang.ca/notes/mcgill/comp251/practice/)

# Big O

| | | | |
--- | --- | --- | --- 
Sorting | Typical | Θ(log n) | Heap sort, Merge sort, Bubble sort, etc 
Hasing | Insertion | O(1) | Add to beginning
| | Deletion | Seach time + O(1) | Using doubly linked list
| | Search | Worst: O(n)<br/>Expected: Θ(1 + α) | worst if all keys are in one slot <br/> α = n/m = #keys/#slots
Heaps | Typical | O(log n)
| | buildMaxHeap | O(n)
Red Black Trees | Typical | O(log n) | Balanced height is at most log n
Find/Union | Quick Find | O(1)
| | Union | O(log n)

Adjacency Representation

| | | | |
---|---|---|---
List | Search | Worst: Θ(V)
| | Storage | Θ(V + E)
Matrix | Storage Space | Θ(V<sup>2</sup>) 
BFS, DFS, SCC | Total Runtime | Θ(V + E) | V = vertex set, E = edge set
Kruskal's Algorithm | Total | O(E logV) &rarr; O(logV) | Notice \|E\| &le; \|V\|<sup>2</sup>
Prim's Algorithm | Total | O(E logV) | with binary heaps <br/> O(E + V logV) with Fibonacci heaps
Dijkstra's Algorithm | Total | O(E logV) | with binary heaps <br /> O(E + V logV) with Fibonacci heaps
Gale Shapley | Total | O(n<sup>2</sup>) | Best case Ω(n)
Bipartite Matching | Runtime | O(nm) 
Weighted Interval Scheduling | Memoization | O(n logn) | O(n) if presorted
Dynamic Programming | Backtracking | O(n) | Usually, given each backtrack has constant time.
Needleman-Wunsch | Total | Θ(mn) | m, n are sequence lengths
| | Space | Θ(mn) 
| | Optimal Value Space | Θ(m + n) | Still with Θ(mn) runtime, but we cannot recover optimal alignment
Bellman-Ford | Total | O(VE) 
Knapsack Problem | Possible | Θ(nW) | W is integer weight
| | Space | Θ(nW) 