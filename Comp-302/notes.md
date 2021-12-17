# Comp 302

> [Brigitte Pientka](mailto:bpientka@cs.mcgill.ca?Subject=Comp%20302) &bull; [OCaml](http://ocaml.org/) &bull; [Prof's Website](http://www.cs.mcgill.ca/~bpientka/)

# Lecture 1 • 2017/09/12
* 5 hw (25%), midterm (10%), final (65%)
* Office hours – McConnell Eng. 107N – Tue, Thu 11:30am – 12:30pm; Thu 4:00pm – 5:30pm
* Goals
  * Introduce fundamental concepts – higher-order functions, state-full vs state-free, modelling objects & closures, exceptions to defer control, continuations to defer control, polymorphism, partial evaluation, lazy programming, etc
  * Show ways to reason about programs – type checking, induction, operational semantics, QuickCheck, etc
  * Introduce fundamental principles in programming language design
  * Grammar & parsing, operation semantics & interpreters, type checking, polymorphism, subtyping
  * Expose students to different way of thinking about problems
* Thorough notes for this class will be up on MyCourses each week

# Lecture 2 • 2017/09/14
* Statically typed programs approximate runtime behaviour & analyze programs before executing them; help find & fix bugs before testing
* Functional languages are primarily expressed via functions They are first-class (you may pass & return functions)
  * Pure functional languages (eg Haskell) don't allow any modifications for variables, and do not provide exceptions
  * Not pure functions (eg OCaml) allows for other paradigms as well
* Call-By-Value – execute when instruction is reached
* Lazy – execute once it is needed to compute other instructions
* Keywords & Operators
  * +, –, *, / are for (int, int) -> int functions
  * +., –., *., /. are for (float, float) -> float functions
* in – keyword for using a variable locally
  * When  the same variable is recreated, it overshadows the previous one. It does not update the previous binding

# Lecture 3 • 2017/09/15
* Tail-recursive functions are ones with nothing to do except return the final value. For such functions, saving its stack frame is redundant.
* User defined data types: type suit= Clubs | Spades | Hearts | Diamonds
  * Set; order doesn't matter
* Passing Arguments
  * At the same time (tuples): 'a * 'b, where ' denotes any value and * is used for creating tuple types
* One at a time: 'a -> 'b -> 'c
  * Currying: translating functions from passing one argument at a time to all at once; opposite is uncurrying
* Non recursive data types can be created like so:
  * type suit = Clubs | Spades | Hearts | Diamonds
  * Clubs, Spades, Hearts, Diamonds are constructors
* Pattern matching is of the syntax `match [expr] with | [pattern] -> [expr] ...`
  * An underscore (wild card) may be used as a pattern that accepts all inputs

# Lecture 4 • 2017/09/19
* Recursive Data-Type
  * type card = rank * suit
  * type hand = Empty | Hand of card * hand
  * -Hand is a constructor defined within hand through the keyword 'of'
  * -A type 'hand' is either 'Empty' or a combination a card to an existing hand
* Types are defined with lower case, and constructors are capitalized

# Lecture 5 • 2017/09/21
* Talked about lists. Up until now, the majority of our content is on syntax. I have made a page detailing some components [here](https://www.allanwang.ca/coding/ocaml/) <!-- TODO update -->