# Math 323

> Chien-Lin Su

{% include mathjax_commands_323 %}

# Lecture 1 - 2018/01/10

* Midterm is on Mar 14<sup>th</sup>

## Chapter 1 - Probability Introduction

### 1.1. Definitions

> Experiment - process by which an observation is made

* Ex dice tossing is an experiment since we observe the number appearing on the other side

* Random Experiment
> Random experiment - TODO

> Sample space - S or &Omega; - collection of every possible outcome

> Event - A, B, C - partial collection of sample space

Let P(A) = probability of A &forall;A, A &isin; &Omega;
P(A) has the following axioms:

* $P(A) \ge 0$
* $P(S) = 1$ (unit measure / normed)
* if $i \ne j$ and $A_i \cap A_j = \emptyset$, $P(A_i \cup A_j) = P(A_i) + P(A_j)$

# Lecture 2 - 2018/01/12

<!-- 1.3, A \subset B should by A \subseteq B -->

> Limit of a sequence of sets

## Limit of Sequence of Sets

> Non-decreasing sequence - sequence of $A_i$ such that $A_j \subseteq A_k$ if $i < k$

> Non-increasing sequence - sequence of $A_i$ such that $A_j \supseteq A_k$ if $i > k$

<!-- <details><summary>Examples</summary><p> -->

### Example 1

$$\begin{align}
\text{Let } A_k & = \braces{x \mid 1 < x \le 2 - \dfrac{1}{k}} \\
A_1 & = \braces{x \mid 1 < x \le 2 - \dfrac{1}{1}} \\
A_2 & = \braces{x \mid 1 < x \le 2 - \dfrac{1}{2}} \\
& ...
\end{align}$$

Note that the sequence is non-decreasing.

$\limitinfty = \cupinfty = \braces{x \mid 1 < x < 2}$

Note that $x < 2$ is open

### Example 2

$A_k = \braces{x \mid 1 < x \le x + \dfrac{1}{k}}$

Note that the sequence is non-increasing.

$\limitinfty = \capinfty = \braces{x \mid 1 < x \le 1} = \emptyset$

Note that $x \le 1$ is still closed.

<!-- <p></details> -->

