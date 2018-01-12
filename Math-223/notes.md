# Math 223
{% include mathjax_commands_223 %}
## Lecture 2 - 2018/01/11

$v \subseteq \real^n$ is a subspace of $\real^n$ if

| 1. $\vec{O} \in V$ | ie $V$ is non empty |
| 2. $\vec{u} + \vec{v} \in V$ | whenever $\vec{u} \in V + \vec{\alpha} \in V$ |
| 3. $\alpha \vec{u} \in V$ | whenever $\vec{u} \in V, \vec{\alpha} \in \real$ |

A subspace $V$ of $\real$ has a basis

ie a family $\vectorset{u}$ of vectors in $V$ such that $\vectorset{u}$ is a spanning set of $V$

> Spanning set of $V$ - set such that every vector in $V$ is a linear combination of that set

ie whenever $\vectorseqtwo{\alpha}{u} = \vec{0}$ then $\alpha_1 = \alpha_2 = ... = \alpha_k = 0$

if $A\alpha = 0$, rank of $A$ is $k$ (&le; n), where k = dimension of $V$

<!-- <details><summary>Examples</summary><p> -->

---

$E = \braces{\vec{u} = \m{t\\\\2t + s\\\\1}, t \in \real, s \in \real} \subseteq R^3$
* $E$ is not a subspace of $R^3$ as the 0 matrix is not included

---

$F = \braces{\vec{u} = \m{t + s\\\\2t + s'\\\\1}, t, s' \in \real} \subseteq R^3$

$\vec{u} \in F \Rightarrow \m{t + s\\\\2t = s'\\\\0} = t\m{1\\\\2\\\\0} + s'\m{1\\\\-1\\\\0}$

$F =$ span $\braces{\m{1\\\\2\\\\0}, \m{1\\\\-1\\\\0}}$ (linearly independent)

---

let $A = \m{1, 1\\\\2, -1\\\\0, 0} \rightarrow \m{1, 0\\\\0, 1\\\\0, 0}$

Rank(A) = 2: therefore $\braces{\m{1, 1\\\\2, -1\\\\0, 0} \m{1, 0\\\\0, 1\\\\0, 0}}$ is linearly independent.

<!-- </p></details> -->
