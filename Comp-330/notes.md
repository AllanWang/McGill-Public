# Comp 330

> [Course Email](mailto:cs330@cs.mcgill.ca?Subject=Comp%20330) &bull; [Course Webpage](http://crypto.cs.mcgill.ca/~crepeau/COMP330/) &bull; [Facebook Group](https://www.facebook.com/groups/mycomp330/)

# Lecture 1 • 2017/09/05
* A <b>language</b> <i>L</i> is any subset of <i>&Sigma;<sup>*</sup></i>, which represents all sequences of elements from a finite set <i>&Sigma;</i>
* An algorithm <i>A</i> <u>decides</u> a language <i>L</i> by answering if x &isin; L
* Languages that we can <u>decide</u> = languages that we can <u>describe</u> – <u>all</u> languages
  * Decided languages and described languages are similar in size (#&#8469;), but both are much smaller than the total available # of languages (#&#8477;)
  * Two sets have the same cardinality if there exists a one to one mapping with all elements from set A to set B without any remaining elements in either sets
* <b>PCP – Post Correspondence Problem</b> – Given tiles with a top sequence and a bottom sequence, find a sequence of such tiles (using any number of any tile) where the concatenated top sequence matches the concatenated bottom sequence
  * PCP cannot be decided by any algorithm in a finite amount of time when there are no valid sequences
  * Proof by reduction technique – if PCP was decidable, then another undecidable problem (the halting problem) would be decidable
* <b>The Halting Problem</b> – Given an algorithm and an input, will the algorithm halt on that input or will it loop forever?
  * Algorithms can be fed an input matching their algorithm to return an incorrect response; no algorithm can be always correct
* <b>Syracuse Conjecture</b> – For any integer n > 0, where S<sub>1</sub> = n, S<sub>i+1</sub> = if (S<sub>i</sub> % 2 == 0) S<sub>i</sub>/2 else 3S<sub>i</sub> + 1, Syracuse(n) = lease i such that S<sub>i</sub> = 0 if S<sub>k</sub> > 1 for all k in [1, i)

# Lecture 2 • 2017/09/07
* Syracuse Conjecture – &forall;n[n > 0 &rArr; Syracuse(n) > 0]
* Not all simple looking problems can  be easily solved; for instance: x/(y + z) + y/(x + z) + z(y + z)
* <b>NP-Complete</b> Problems
  * If any of them is easy, they are all easy
    * In practice, some of them have special cases which may be more efficiently solved
  * 3-colouring of Maps; hard to solve (no known efficient algorithm), but are easy to verify
  * SAT – given boolean formula, is there an assignment to make the formula evaluate to true?
  * Travelling salesman – given cities & distances between them, what is the shortest route to visit each city once?
  * Knapsack – given items with various weights, is there a subset with total weight K?
* <b>P</b> – Tractable problems – Solvable in polynomial time
  * Some problems may be efficiently solvable, but algorithm may not be provable
  * 2-colorability of maps
  * Primality testing (probably not factoring)
  * Solving N x N x N Rubik's cube
  * Finding word in dictionary
  * Sorting elements
* <b>NP-hard</b> – broader term for NP questions that do not fall in the category of a language
* <b>PSpace Completeness</b> – problems requiring reasonable (Poly) amount of space to be solved, but may use very long time
* <b>Finite-State Automata</b> – simple model where there can be exactly one of a finite number of states at any given time
  * Example: swinging door, elevator
* <b>DFA</b> – deterministic finite automaton, 5-tuple (Q, &Sigma;, &delta;, q<sub>0</sub>, F)
  * States – finite set Q (circle)
  * Alphabet – finite set &Sigma;, defines a language (letters)
  * Transition function – explicit representation mapping states & alphabets to states (&delta; = Q x &Sigma; &rarr; Q)
  * Start state – special state representing entry point, q<sub>0</sub> &isin; Q (arrow to state)
  * Accept states – decision making state, F &sube; Q (double circle)

# Lecture 3 • 2017/09/12
* Next tuesday's class is cancelled
* Prof. Cr&eacute;peau's office hours are cancelled next week
* Regular Languages
  * Given definition from last class, and let w = w<sub>1</sub>w<sub>2</sub>...w<sub>n</sub> (n &ge; 0) be a string where each symbol w<sub>i</sub> is from the alphabet &Sigma;<br/>M <b>accepts</b> w if states s<sub>0</sub>,s<sub>1</sub>,...s<sub>n</sub> exist s.t
    * s<sub>0</sub> = q<sub>0</sub>
    * s<sub>i+1</sub> = &delta;(s<sub>i</sub>, w<sub>i+1</sub>) for i = 0, ... n – 1
    * s<sub>n</sub> &isin; F
    * (w is accepted if it starts at the start state and ends at an accept state)
  * Note that the size of the state is typically one greater than the size of the string
  * M <b>recognizes language</b> A if A = { w &#124; M accepts w }
  * A language is a <b>regular language</b> if some finite automaton recognizes it
* [Went through example proof by induction]
* &epsilon; represents an empty string

# Lecture 4 • 2017/09/14
* 
  Regular Operations | | |
  ---|---|---
  Union | A &cup; B | { x &#124; x &isin; A or x &isin; B }
  Concatenation | A &compfn; B | { xy &#124; x &isin; A and y &isin; B }
  Star | A* | { x<sub>1</sub>x<sub>2</sub> ... x<sub>k</sub> &#124; K &ge; 0 and each x<sub>i</sub> &isin; A }
* Non-Deterministic Finite Automata
  * May jump from state to state without consuming input (eg when encountering the empty string &epsilon;)
  * Definitions are similar to DFA, except that:
    * Alphabet – also includes an empty string &epsilon;
"--Transition function returns P(Q), which is a subset (partition) of Q that meets the requirements"  

# Lecture 5 • 2017/09/21
* (No class on 19<sup>th</sup>)
* Minimization of DFA
  * Lumping (quotient by an equivalence relation) – if two states lead to the same state(s) at all times, and are the same 'state' themselves, they may be merged together as their difference is forgotten after the next step.
  * ~ (equivalence relations) are
    | | | |
    ---|---|---
    Reflexive | &forall;x | x ~ x
    Symmetric | &forall;x,y | x ~ y &rArr; y ~ x
    Transitive | &forall;x,y,z | x ~ y, y ~ z &rArr; x ~ z
  * S/~ represents [s] = { x &#124; x ~ s }
* &delta;(s, a) – state you went to after reading alphabet a at state s
* &delta;*(s, w) – state you went to after reading all letters in word w, starting at state s
* M = (s, s<sub>0</sub>, &delta;, F)<br/>L(M) = { w &#124; &delta;*(s<sub>0</sub>,w) &isin; F }
* Def p, q &isin; S are <u>equivalent</u> (p &asymp; q) if<br/>&forall;w &isin; &Sigma;* &ensp;&ensp; &delta;*(p,w) &isin; F &hArr; &delta;*(q,w) &isin; F
* Lemma A
  * p = q &rArr; &forall;a &isin; &Sigma; &ensp;&ensp; &delta;(p,a) &asymp; &delta;(q,a)
  * Note that p &asymp; q can be written [p] = [q] (comparing equivalence classes)
    * Therefore: [p] = [q] &rArr; [&delta;(p,a)] = [&delta;(q,a)]
* For a new machine M' = (s', s<sub>0</sub>', &delta;', F')
  * s' = s/&asymp;
  * s<sub>0</sub>' = [s<sub>0</sub>]
  * &delta;'([s],a) = [&delta;(s,a)]
  * F' = { [s] &#124; s &isin; F }
* Lemma B
  * if p &isin; F & q &asymp; p, then q &isin; F
* Lemma C
  * &forall;w &isin; &Sigma;* &ensp;&ensp; &delta;'*([p],w) = [&delta;*(p,w)]
  * Proof by induction
* Theorem: L(M') = L(M)
* Proof
  * x &isin; L(M') &hArr; &delta;'*([s<sub>0</sub>], x) &isin; F'
  * &hArr; [&delta;*(s<sub>0</sub>,x)] &isin; F'
  * &hArr; &delta;*(s<sub>0</sub>,x) &isin; F
  * &hArr; x &isin; L(M) &#8718;
* 41:29