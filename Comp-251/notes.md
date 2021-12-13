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

# Lecture 0 • 2017/01/05
* Office Hours Tues/Thu 1-2pm
* 40% for 5 assignments, 15% for midterm, 45% for final exam
* Midterm March 9 (one crib sheet permitted), during class time
* End of class April 11
* Final exam TBD

# Lecture 1 • 2017/01/10
* *** A significant portion of the lecture overlaps with comp 250, so I did not add much about it here ***
* `f(n)` is `O(g(n))` iff there exists a point n0 beyond which `f(n)` is less than some fixed constant times `g(n)` → for all `n ≥ n0`, `f(n) ≤ c * g(n)` (for some `c > 0`)
* Let `T1(n) = O(f(n))` & `T2(n) = O(f(n))`
  * `T1(n) + T2(n) = O(f(n))`
  * `T1(n) / T2(n)` is not necessarily `O(1)`; big O is not necessarily the tightest upper bound.
  `T1(n) = 3n & T2(n) = 2n` is an example.
* Heap – binary tree such that
  * For any node n other than the root, `key(n) ≥ key(parent(n))`
  * Let h be the height of the heap
    * First `h – 1` levels are full
    * At depth h, leaves are packed on the left side of the tree

# Lecture 2 • 2017/01/12
* Table S with n records of x
  * X is key, key[x] → satellite data
  * Insert(S, x): S ← S ∪ {x}
  * Delete(S, x): S ← S \ {x}
  * Search (S, k)
  * Direct Address Table – each slot/position corresponds to key in U
    * If x has key k, T[k] points to x
    * If T[k] is empty, represented by NIL
    * All operations O(1), but if #keys < #slots, lots of wasted space
  * Hash Table – reduce storage, resolve conflicts by chaining, ave O(1) search time, not worse case
  * Hashing with Chaining
    * Insertion – O(1) – insert at beginning
    * Deletion – search time + O(1) if we use doubly linked list
    * Search
* Worst case – O(n)
  * Time to computer has function + time to search the list
  * Assuming time to compute is O(1)
  * When all keys go on same slot
* Average – depends how keys are distributed
  * Load factor α = n/m n = #keys, m = #slots
    * Theorem – expected time of search is Θ(1 + α)
* O(1) if α < 1, O(n) if α is O(n)
* Proof – unsuccessful vs successful
* Successful search
  * 1/m probability of collision – after finding x have been inserted in hash table before x (ie we insert at head)
  * 1 + α/2 + α/(2n)
* Hash functions
  * A good hash function should uniformly distribute the keys into slots, and should not be affected by patterns in keys
  * Division method – `h(k) = kmod d`
    * D must be d chosen carefully, usually 2<sup>r</sup> where r is a prime not too close to a power of 2 or 10
    * Easy to implement, but division is slow
  * Multiplication method – <code>h(k) = (A kmod2<sup>w</sup>) >> (w – r)</code>
    * Extracted bits are in the middle of the binary key
* Open addressing
  * No chaining; if slot is not empty, try another has function
  * Collisions exist; resolved by adding another slot
  * We can delete elements in open address tables
  * Cannot store more records than total number of slots in table
  * Deletion is difficult
* Goal is uniform hashing – each key is equally likely to have any permutation as its probe sequence
* Theorems
  * Expected # of probes in unsuccessful search is at most `1/(1 - α)`
  * Expected # of probes in successful search is at most `1/α * log(1/(1 - α))`
* Probing
  * Linear – h(k, i) = (h’(k) + i)mod m
    * If slot is full, check next slot; tendency to create clusters
  * Quadratic probing – <code>h(k, i) = (h’(k) + c<sub>1</sub>i + c<sub>2</sub>i<sup>2</sup>)mod m</code>
    * Must ensure we have full permutation of <0, …, m – 1>
    * Secondary clustering – 2 distinct keys have same h’ value if they have same probe sequence
* Double hashing – <code>h(k, i) = (h<sub>1</sub>(k) + i * h<sub>2</sub>(k)) mod m</code>
  * <code>h<sub>2</sub>(k)</code> should be “relatively” prime to m to guarantee full permutation

# Lecture 3 • 2017/01/17
* Max heap – largest element stored at root; all children are smaller
* Min heap – smallest element stored at root; all children are bigger
* Heaps as array – `root = A[1], left[i] = A[2i], right[i] = A[2i + 1], parent[i] = A[i/2]`
* Height - # of edges on longest simple path from node to leaf
* Height of heap = height of root = Θ(log n)
* Basic operations are O(log n)
* <details>
  <summary>Heap Pseudocode (Comp 250)</summary>
  
  ```java
  /*
   * Priority Queues - each node is smaller than all of its descendents
   *      root is therefore the smallest element
   * Complete Binary Tree - binary tree with all levels above the lowest one full
   *      and with all elements in the lowest level as left as possible
   * Heaps can be visualized as trees, but can also be represented with arrays
   *      if we number the nodes 1 through n, starting from the root and travelling breadth first,
   *      the numbers will represent their indices in the array (0 is not used for convenience)
   *      the left child of node k is therefore at 2k, and the right child is at 2k + 1
   */

  public class Heap {

      //add element at end then reorganize with upHeap
      void add(E element) {
          Node cur = newLastNode() //Node on lowest level right of the last existing node
          cur.element = element
          while (cur != root && cur.element < cur.parent.element) {//Node is smaller than parent
              swapElement(cur, parent) //switch values
              cur = cur.parent //go up a level
          }
      }

      //remove root, replace with last node, then reorganize with downHeap
      E removeMin() {
          E min = root.element //this is the smallest element
          Node cur = root //just a name change; currently refers to root
          cur.element = getLastNode().element //Get element of rightmost node on last level
          getLastNode() = null //last node has moved and no longer exists
          while (cur.leftChild != null) { //if null, there are no children
              if (cur.leftChild.element < cur.element) {
                  swapElement(cur, cur.leftChild) //left child smaller; swap
                  cur = cur.leftChild
              } else if (cur.rightChild != null && cur.rightChild.element < cur.element) {
                  swapElement(cur, cur.rightChild) //right child smaller; swap
                  cur = cur.rightChild
              }
          }
          return min
      }

      /*
       * Equivalent methods but in an array implementation
       */
      void add(E element) {
          size++ //it is assumed the array can fit this size
          heap[size] = element //size matches last index as 0 is not used
          i = size //iterate through 'parent nodes'
          while (i > 1 && heap[i] < heap[i / 2]) {
              swapElements(heap[i], heap[i / 2])
              i /= 2
          }
      }

      /*
       * Create heap from unsorted list
       * Best case is O(n) -> already a heap
       * Worst case is O(nlogn) -> move every item at k floor(logk) steps up
       */
      Heap buildHeap(list) {
          heap = new Heap(list.size)
          for (E element : list)
              heap.add(element) //see method above; adds and reorganizes
          return heap
      }

      E removeMin() {
          E min = heap[1] //root; index 0 not used
          heap[1] = heap[size]
          heap[size] = null //element moved
          size--
          downHeap(1, size)
          return min
      }

      /*
       * Moves element at index i to appropriate position within the heap
       */
      void downHeap(i, size) {
          while (2 * i <= size) { //left child exists
              child = 2 * i
              if (child < size) { //right child exists
                  if (heap[child + 1] < heap[child]) //right child smaller
                      child++ //child is now indexed at smallest of the two children
              }
              if (heap[child] < heap[i]) { //child smaller than current
                  swapElements(heap[child], heap[i])
                  i = child
              }
          }
      }

      //you can actually use heaps to sort your values
      E[] heapSort(list) {
          heap = buildHeap(list)
          E[] sorted = new E[list.size + 1]
          for (i = 1 to list.size){
              sorted[size - i] = heap.removeMin() //add min from left to right
          }
          return sorted
      }

      //sort within same array
      E[] heapSort(E[] arr) {
          heap = buildHeap(arr)
          for (i = 1 to list.size){
              swapElements(heap[1], heap[size + 1 - i]) //smallest element of subarray is moved to the back
              downHeap(1, size - i) //shift root element down, bringing next smallest to root
          }
          return reverse(heap) //reverse for small to large
      }

      /*
      * Previous methods rely on add(E), which uses upHeap
      * As half the elements are on the bottom row, it is much more efficient to downHeap
      * We start at k = size/2 because all k's greater are already at smallest height
      * Algorithm is O(n)
      * t(n) = Sigma(i = 0 -> n)(height of node i) = n - log(n + 1)
      */
      buildHeapFast(list) {
          for(k = size/2; k >= 1; k--)
              downHeap(k, size)
      }
  }
  ```
  </details>
* Maintaining heap property
  * Fix offending node by exchanging value at node with larger of the values at its children
  * Recursively fix until there are no more offenses
* Running time of buildMaxHeap is O(n)
  * maxHeapify = O(log n); heap height = log n;
  $$O \left( n \sum_{h=0}^{\lfloor log n \rfloor}\dfrac{h}{2^h} \right)$$
* HeapSort is O(n logn)

# Lecture 4 • 2017/01/19
* BST search, insert, delete are Θ(h); h = height of BST
* Height(x) = 1 + max(height(x.left), height(x.right))
* A good BST is balanced, height = Θ(log n)
* A bad BST is unbalanced, height = Θ(n)
* AVL – self balancing BST – Adelson-Velsky & Landis
  * Height of one child is at most one greater than the other
  * Each node contains data to indicate which child is bigger, or if they have the same height
  * Rotations are used to maintain balanced properties
* Rotations
  * Remove zigzags
    * If a.left = b and b.right = c, rotate b leftwards
    * Result: a.left = c and c.left = b
  * Reattach children properly
    * If a.left = b, b.left = c, b.right = d, a.right = e, rotate b rightwards
    * Result: b.right = a, a.right = e, b.left = c
    * Reattach middle child (d) to right child or local root → a.left = d

# Lecture 5 • 2017/01/24
* Recursive equation for best case running time of function heapify on heap size of n? Ω(1)
* Red Black Trees
  * Always balanced height is O(logn) worst case operations are O(logn)
  * +1 bit per node for attribute color: red or black
  * Empty trees are black and will be referenced as nil
  * Properties
    * Every node is red or black
    * The root and every leaf is black
    * If a node is red, its children are black
    * For each node, all paths from the node to descendant leaves contain same number of black nodes (same black height)
  * Let
    * h(x) = # of edges in longest path to leaf
    * bh(x) = # of black nodes from x to leaf, not counting x and counting the leaf
    * Black height of RBT = bh(root)
  * Note
    * `h(x)/2 ≤ bh(x) ≤ h(x) ≤ 2bh(x)`
    * A subtree rooted at any node x has <code>≥ 2<sup>bh(x)</sup> – 1</code> internal nodes
    * A RBT with n internal nodes has height `≤ 2lg(n+1)` (proof by previous point)
* <details>
  <summary>Pseudocode</summary>

  ```java
  /*
   * Red Black Tree Implementation
   */
  public class RedBlackTree {

      /**
       * Inserts a node at its proper position and makes it red
       *
       * @param tree the red black tree
       * @param z    the node to insert
       */
      void insert(tree, z) {
          y = nil[tree] //initialize reference
          x = tree.root
          while (x != nil[tree]) {
              y = x
              if (z.key < x.key) x = x.left
              else x = x.right
          }
          //we've found the proper location; add z as child
          z.parent = y
          if (y == nil[tree]) tree.root = z
          else if (z.key < y.key) y.leftChild = z
          else y.rightChild = z

          /*
           * Node is now added
           * Proceed to check the three cases below
           * and continue "fixing" until the root is reached
           * Grandparent of x is x.parent.parent
           * Uncle of x is sibling of x.parent (other child of grandparent)
           */
      }

      /**
       * Uncle is red;
       * we will swap the colors of the parent, uncle, and grandparent,
       * which brings the conflict one level higher
       * we will assume that the grandparent exists
       *
       * @param z the node to insert
       * @return new potential conflict node
       */
      Node case1(tree, z) {
          //by properties, the grandparent must be black -> swap
          z.parent.parent.color = red
          //swap colors for red father and uncle
          z.parent.color = black
          z.uncle.color = black
          //Only conflict now is from grandparent and its parent
          return z.parent.parent
      }

      /**
       * Uncle is black, so we cannot swap it to red
       * We will also assume that z, z.parent, and z.parent.parent are not inline (one is left child, one is right)
       * We will now align them through rotation and proceed to case 3)
       * In this case, we shall assume that the
       * z.parent.parent.leftChild z.parent
       * And z.parent.rightChild = z
       *
       * @param z the node to insert
       * @return new potential conflict node
       */
      Node case2(z) {
          //this is simply a generic rotation
          p = z.parent
          z.parent = p.parent
          p.parent = z
          p.rightChild = z.leftChild
          z.leftChild = p
          return case3(z) //now that we have the proper arrangement
          //we will proceed to case3
      }

      /**
       * Uncle is black, z is inline with parent and grandparent
       * We shall assume that z and its parent are both left children to their respective parents
       *
       * @param z the node to insert
       * @return new potential conflict node
       */
      Node case3(z) {
          //swap colors for parent and grandparent
          z.parent = black
          z.parent.parent = red
          rotateRight(z, z.parent) //z will now be the parent
          z.color = black //z the local root is now black
          z.parent.color = red //z.parent the child is now red
          return z
      }
  }
  ```
  </details>

# Lecture 6 • 2017/01/26
* Disjoint Sets
* Connected components – set of nodes connected by a path
  * Every node in the set can be reached by every other node (path itself is irrelevant)
* Partition – set of objects split into disjoint subsets
  * The union of all sets will produce the original set
  * No two sets share a common node unless those sets are the same set; every set is disjoint from all the other sets
* Map vs Relation
  * Maps lay out a unidirectional property from elements in one set to the other
  * Relation defines a bidirectional connection (ie boolean matrix)
* Equivalence – i is equivalent to j if they belong to the same set (are connected)
* Reflexivity - `∀ a ∈ S, (a, a) ∈ R`
  * For all `u ∈ V`, there is a path of length 0 from u to u
* Symmetry - `∀ a, b ∈ S, (a, b) ∈ R ⇒ (b, a) ∈ R`
  * For al `u, v ∈ V`, there is a path from u to v iff there is a path from v to u
* Transitivity - `∀ a, b, c ∈ S, (a, b) ∈ R ∩ (b, c) ∈ R ⇒ (a, c) ∈ R`
  * For all `u, v, w ∈ V`, if there is a path from u to v and a path from v to w, there is a path from u to w
* ADT (abstract data type)
  * find(i) - returns representative of set that contains i 
  * sameset(i, j) - returns find(i) == find(j) 
  * union (i, j) - merges sets containing I and j 
    * Does nothing if they are already in the same set
* When merging trees, smaller tree should be merged below root of larger tree to minimize height; height will therefore only increase when the trees initially have the same height
  * Rank – upper bound on height of nodes
* Path Compression – make all nodes in find path direct children of root
* <details>
  <summary>Disjoint Set Pseudocode</summary>

  ```java
  /*
   * Pseudocode for Disjoint Set Optimization
   */
  public class Disjoint {

      /**
       * Finds root node of a subset containing i
       * Also undergoes path compression, where the nodes will become
       * direct children of the root
       *
       * Worst case is O(logn) (we can prove that the height is at most logn)
       *
       * @param i node contained in subset
       *
       * @return root node
       */
      Node find(i) {
          if (i.parent == i) return i //i is the root
          return i.parent = find(i.parent) //set parent of i to root & return the root
      }
  }
  ```
  </details>
