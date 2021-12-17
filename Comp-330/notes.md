# Comp 330

> [Course Email](mailto:cs330@cs.mcgill.ca?Subject=Comp%20330) &bull; [Course Webpage](http://crypto.cs.mcgill.ca/~crepeau/COMP330/) &bull; [Facebook Group](https://www.facebook.com/groups/mycomp330/)

# Lecture 1 • 2017/09/05
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

# Lecture 2 • 2017/09/07
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

# Lecture 3 • 2017/09/12
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

# Lecture 4 • 2017/09/14
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

# Lecture 5 • 2017/09/21
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

# Lecture 6 • 2017/09/21
* Reflexive, symmetric, transitive
* S~ represents an equivalence class, where S is the set & ~ represent equal
* &delta;(s, a) – state you went to after reading alphabet a at state s
* &delta;*(s, w) – state you went to after reading all letters in word w, starting at state s

# Lecture 7 • 2017/09/26
* Every NFA can be done with a DFA
* E(R) = { q &#124; q can be reached from R by traveling along 0 or more &epsilon; arrows }
* R is a regular expression if
  * <i>a</i> for some <i>a</i> in alphabet &Sigma;
* &epsilon;
* &empty;
* Union, concatenation, and star of regular expressions are regular expressions

# Lecture 8 • 2017/09/28
* Lemma – if a language is regular, then it is described by a regular expression
* Generalized NFA
  * Start state has transition arrows to every other state, but no arrows coming in from any other state
  * Single accept state, with arrows coming in from every other state and no arrows from any other state. The accept state cannot be the start state
  * For all other states, one arrow goes from every state to every other state
    * In other words, \delta;: (Q – {q<sub>accept</sub>|) x (Q - {q<sub>start</sub>}}) &rarr; R is the transition function
* GNFA &rarr; regex
  * Basis – if GNFA has 2 states, the states are a start & accept state with a single transition to the accept state

# Lecture 9 • 2017/10/03
* Reduction
  * Given B = { 0<sup>n</sup>1<sup>n</sup> &#124; n &ge; 0 }
  * Given C = { w &#124; w contains an equal number of 0s & 1s }
  * If C is regular, then so is B
  * If B is nonregular, then so is C
  * Proof
    * We can define A = L(0<sup>*</sup>1<sup>*</sup>), which is obviously regular; if C was regular than so would C &cap; A = B
  * Simple Reductions
    * If A<sup>*</sup> is nonregular, then so is A
    * If A is nonregular, then so is A<sup>C</sup>
    * If A is nonregular, then so is A<sup>R</sup>
  * Complex Reductions (let all Rs be regular)
    * For A' = (A &cup; R) &cap; (A<sup>C</sup> &cup; R')
    * For A' = ((A<sup>C</sup> &cap; R) &cup; (A<sup>*</sup> &cap; R')) &compfn; R''
    * For A' = (A &compfn; R) &cap; (A<sup>C</sup> &compfn; R')
    * If A' is nonregular, then so is A

# Lecture 10 • 2017/10/05
* Myhill-Nerode Theorem
* A set of strings (X) is pairwise distinguishable by language L is every two elements in X are distinguishable by L (&forall;x, x' in X, x &nequiv;<sub>L</sub> x')
* Define an index of L to be the size of a maximum set X that is pairwise disinguishable by L. L is regular iff the index is finite.
* The smallest index is also the number of states of the smallest DFA recognizing L
  * If DFA has more states than the index, then there must be some x, y in X such that &delta;(q<sub>0</sub>, x) = &delta;(q<sub>0</sub>, y). However, this is not distinguishable, hence contradiction
* Minimal DFAs can be discovered using the Myhill-Nerode Theorem by first discovering the pairwise distinguishable set, then by creating a DFA whose states matches the distinguished set values.

# Lecture 11 • 2017/10/10
* Context-Free Grammar
* Derivation – conversion of word from start variable (typically first symbol in grammar)
  * Eg. Let grammar G<sub>1</sub> = A &rarr; 0A1, A &rarr; B, B &rarr; #
  * Derivation of '000#111': A &rArr; 0A1 &rArr; 00a11 &rArr; 000A111 &rArr; 000B111 &rArr; 000#111
* | CFG Definition | |
  ---|---
  Variables | A, B, C, &lt;TERM&gt;, &lt;EXPR&gt; (Angle brackets denote single variable rather than sequence of letters)
  Alphabet (of terminals) | 0, 1, #
  Substitution Rules | &lt;EXPR&gt; &rarr; &lt;TERM&gt;
  Start Variable | A (LHS of first substitution rule)
* u derives v (u &rArr;<sup>*</sup> v if u = v or if u &rArr; u<sub>1</sub> &rArr; u<sub>2</sub> &hellip; u<sub>k</sub> = v, k &ge; 0.

# Lecture 12 • 2017/10/12
* Chomsky Normal Form
  * Context-free grammar notation for which every rule is of the form A &rarr; BC or A &rarr; &epsilon;
    * B and C must not be start variables
* Any context-free language is generated by a context-free grammar in Chomsky normal form
  * Start by creating start variable S<sub>0</sub> pointing to S, the first variable in the string (this avoids start variable of CFG from appearing on RHS)
  * Remove all A &rarr; &epsilon; rules where A is not start variable
    * This will change rules R &rarr; A to R &rarr; &epsilon;, which will be processed later
    * S &rarr; ASA would become S &rarr; ASA | SA | AS | S
  * Remove all unit rules such as A &rarr; B
  * Convert seqeunce rules A &rarr; u<sub>1</sub>u<sub>2</sub>&hellip;u<sub>k</sub> (where k &ge; 2) to a series of rules A &rarr; u<sub>1</sub>A<sub>1</sub>, A<sub>1</sub> &rarr; u<sub>2</sub>A<sub>2</sub> etc, where each A<sub>i</sub> is a new variable
* Pushdown Automata (stack type)
* Has alphabet<b>s</b> – one for the inputs (lowercase) & one for the stack (uppercase)
  * In most cases, the stack alphabet will be larger than that of the inputs
  * b,B &rarr; A means that if input is b & stack top has B, digest b and replace top stack with A
    * b,&epsilon; A means to push A to stack if input is b (popping &epsilon;, which is nothing)
  * Note that stack usage means that we can only see the top item of the stack. There is no notion of moving through the stack

# Lecture 13 • 2017/10/17
* Gave more examples on PDA
* Theorem – a language is context free iff some PDA recognizes it
* CFG to PDA
  * Place marker symbol $ & start variable on stack
  * Repeat following forever
    * If top stack is A, nondeterministically select one of rules for A & substitute
    * If top stack is terminal symbol &alpha; read next symbol from input & compare to &alpha;. If match, repeat, otherwise reject
    * If top stack is symbol $, enter accept state. This will accept the input if it has been completely read

# Lecture 14 • 2017/10/19
* If x can bring P from <i>p</i> with empty stack to <i>q</i> with empty stack, A<sub>pq</sub> generates x
  * If computation has 0 steps, x is already the empty string
  * Induction - assume true for length k, prove for k + 1
    * Once that stack is non empty, it will become empty either at the very last step of at some intermediate point
      * If never happened in between, symbol p i pushed at the first move and popped at the last step
        * For any portion y = azb, with y transitioning from empty state to empty state, we may do the same for z without the need of passing through transitions a and b (given that there does not exist an empty state in between)
      * If empty state exists in between, transitions can be split by the empty states. Note that the sum of those transitions must be less than the total number of steps, as it requires at least two steps to pop into an empty state and push back into a nonempty state
  * Pumping Lemma for CFLs
    * One way only; not iff
    * A context-free language L must have a number p where, if s is any string in L of length &ge; p, s may be divided into uvxyz such that:
      * for each i &ge; 0, uv<sup>i</sup>xy<sup>i</sup>z &isin; A
      * |vy| > 0
      * |vxy| &le; p