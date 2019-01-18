# Software Reflection Models

[pdf](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=917525)

1, 2, 3, 6 

## 1. Introduction

* Overtime, artifacts drift apart, as they are time-consuming, difficult, or not the highest priority
* When design documents drift
  * Can choose to ignore old ones 
  * Can use higher level models
  * Can choose to reverse engineer high level models from current source
  * Technique proposed - iterative reflection model that exploits drifts between design and implementation 
    * Technique is lightweight, approximate, and scalable

## 2 - An Example

1. Specify model
2. Extract structural information (source model) from artifacts
3. Describe mapping between models and high-level structural model
   * Only relevant models are needed 
4. From name, physical directory, and logical structure, compute software reflection model comparing source and high-level structure
5. Interpret and derive information to help reason with engineering tasks

## Formal Characterization & Tool Support

* Formal characterizations used to
  * Be unambiguous and precise
  * Distinguish points where design choices are possible
* Z specification language used, containing
  * Basic description of reflection model
  * Precise definition of computation
    * Used to determine convergence, divergence, & absence
  * Description of how to compute info for reflection models

### Reflection Model

* Two types
  * `HLMENTITY` - type of high-level model entity
  * `SMENTITY` - type of source model entity
  * Synonyms for relations and entries
* Relations
  * Convergence - models agree
  * Divergence - source differs from high-level 
  * Absence - high-level differs from source
  * `mappedSourceModel` - relation describing which sources contribute to convergent/divergent arc
  * `smBag` - includes all source values & their # of occurrences

## Discussion

### Syntactic Models

* Reflection models are computed independent of high-level or source models
* Syntax model used to interpret reflection models
  * Very flexible
  * Provides lightweight techniques
  * Ensures developer understands structural relations, as they are involved in processing them
* Models 