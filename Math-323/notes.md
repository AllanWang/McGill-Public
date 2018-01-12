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

<details><summary>Examples</summary><p>

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

</p></details>

## 1.4 Partition & Inequalities

> Partition - sequence of mutually exclusive sets which together form the whole. More formally:

Let $\braces{A_i}_{i = 1}^{\infty \(k\)}$ be a sequence of sets

$A_i \le \Omega, \forall i$

If $A_i \cap A_j = \emptyset, \forall i \ne j$ and $\cupinftyup{\infty \(k\)} = \Omega$<br>
then $\braces{A_i}_{i=1}^{\infty \(k\)}$ is a partition of sample space $\Omega$

Note - if $B$ is any subset of $\Omega$ & $\braces{A_1, ..., A_k}$ is a partition of $\Omega \Rightarrow B = \cupinftyup{k} \(A_i \cap B\)$

---

### Theorem 1. Kolmogorov Probability Measure

<!-- F is fancy f -->

Let $F$ be a set that collects possible sets from $\Omega$

P: $F \rightarrow R^+$ is called a probability measure if

&emsp;&ensp;a. $P(A) \ge 0 \quad \forall A \in F \mathcomment{\text{non-negative}}$<br>
&emsp;&ensp;b. $P(\Omega) = 1$<br>
&emsp;&ensp;c. $P\(\cupinfty\) = \Sigma_{i=1}^{\infty} P\(A_i\), A_i \cap A_j = \emptyset \quad \forall i \ne j$

Some extensions:

1. $P(\phi) = 0$
2. $P\(\cupinftyup{k}\) = \Sigma_{i=1}^{k} P\(A_i\), A_i \cap A_j = \emptyset \quad \forall i \ne j$
3. $P(A^C) = 1 - P(A)$
4. $A \subseteq B \Rightarrow P(A) \le P(B)$
5. $P(A \cup B) = P(A) + P(B) - P(A \cap B)$
6. $P(A_1 \cup A_2 \cup A_3) = P(A_1) + P(A_2) + P(A_3) - P(A_1 \cap A_2) - P(A_2 \cap A_3) - P(A_1 \cap A_3) + P(A_1 \cap A_2 \cap A_3)$

Proof

---

Claim: $P(\phi) = 0$

$\because \Omega = \Omega \cup \phi$

$\therefore P(\Omega) = P(\Omega \cup \phi)$

$= P(\Omega) + P(\phi) (\therefore \Omega \cap \phi = \phi)$

$= 1+ P(\phi)$

$\therefore P(\phi) = 0$

---

Claim: $P(A^C) = 1 - P(A)$

$\because \Omega = A \cup A^C$

$\therefore P(\Omega) = P(A \cup A^C)$

$= P(A) + P(A^C) --- (A \cap A^C = \phi)$

$\therefore 1 = P(A) + P(A^C)$

$\therefore P(A^C) = 1 - P(A)$

---

Claim: $A \subseteq B \Rightarrow P(A) \le P(B)$

$P(B) = P(A \cup (A^C \cap B))$

$= P(A) + P(A^C \cap B) --- (A \cap (A^C \cap B) = \emptyset)$

$\ge P(A)$

---

Claim: $P(A \cup B) = P(A) + P(B) - P(A \cap B)$

$\because A \cup B = A \cup (A^C \cap B)$

$\therefore P(A \cup B) = P(A \cup (A^C \cap B)) --- (A \cap (A^C \cap B) = \emptyset)$

$= P(A) + P(A^C \cap B)$

Note: $P(B) = P((A \cap B) \cup (A^C \cap B))$

$= P(A \cap B) + P(A^C \cap B)$

$\Rightarrow P(A^C \cap B) = P(B) - P(A \cap B)$

---

//todo include other stuff

1.5 Conditional Probability and Baye's Rule

Def 1 The conditional probability of an event A, given that an event B has occurred, is equal to 

$P(A \mid B) = \dfrac{P(A \cap B)}{P(B)} if P(B) > 0$

Remark 1:

Here A is the event whose uncertainty we want to update, and B is the evidence we observe (or want to treat as given

We call P(A) the prior probability of A, and P(A \| B) the posterior probability of A.)

> Prior - before updating based on evidence

> Posterior - after updating based on evidence

Remark 2:

$P(A \mid B)$ is a probability measure

Check 1:

$P(A \mid B) = \dfrac{P(A \cap B)}{P(B)} > 0$

Since $P(B) > 0$ and $P(A \cap B) > 0$

Check 2:

$P(\Omega \mid B) = \dfrac{P(\Omega \cap B)}{P(B)} = \dfrac{P(B)}{P(B)} = 1$

Check 3:

see check 3

$\bigcupinfty$