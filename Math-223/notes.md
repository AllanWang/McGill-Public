# Math 223
$\renewcommand{\vec}[1]{\overrightarrow{#1}}$
$\newcommand{\vectorset}[1]{\{\vec{#1_1}, \vec{#1_2}, ..., \vec{#1_k}\}}$
$\newcommand{\vectorseqtwo}[2]{#1_1\vec{#2_1} + #1_2\vec{#2_2} + ... + #1_k\vec{#2_k}}$
## Lecture 2 - 2018/01/11

$v \subseteq \mathbb{R}^n$ is a subspace of $\mathbb{R}^n$ if\
| | |
|---|---|
| 1. $\vec{O} \in V$ | ie $V$ is non empty |
| 2. $\vec{u} + \vec{v} \in V$ | whenever $\vec{u} \in V + \vec{\alpha} \in V$ |
| 3. $\alpha \vec{u} \in V$ | whenever $\vec{u} \in V, \vec{\alpha} \in \mathbb{R}$ |

A subspace $V$ of $\mathbb{R}$ has a basis

ie a family $\vectorset{u}$ of vectors in $V$ such that $\vectorset{u}$ is a spanning set of $V$

> Spanning set of $V$ - set such that every vector in $V$ is a linear combination of that set

ie whenever $\vectorseqtwo{\alpha}{u} = \vec{0}$ then $\alpha_1 = \alpha_2 = ... = \alpha_k = 0$

if $\underbrace{A}_{n \times k} \underbrace{\alpha}_{k \times 1} = \underbrace{0}_{n \times 1}$, rankA(A) = k (&le; n)