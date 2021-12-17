# Comp 302

> [Brigitte Pientka](mailto:bpientka@cs.mcgill.ca?Subject=Comp%20302) &bull; [OCaml](http://ocaml.org/) &bull; [Prof's Website](http://www.cs.mcgill.ca/~bpientka/)

## Lecture 1 • 2017/09/12
* 5 hw (25%), midterm (10%), final (65%)
* Office hours – McConnell Eng. 107N – Tue, Thu 11:30am – 12:30pm; Thu 4:00pm – 5:30pm
* Goals
  * Introduce fundamental concepts – higher-order functions, state-full vs state-free, modelling objects & closures, exceptions to defer control, continuations to defer control, polymorphism, partial evaluation, lazy programming, etc
  * Show ways to reason about programs – type checking, induction, operational semantics, QuickCheck, etc
  * Introduce fundamental principles in programming language design
  * Grammar & parsing, operation semantics & interpreters, type checking, polymorphism, subtyping
  * Expose students to different way of thinking about problems
* Thorough notes for this class will be up on MyCourses each week

## Lecture 2 • 2017/09/14
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

## Lecture 3 • 2017/09/15
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

## Lecture 4 • 2017/09/19
* Recursive Data-Type
  * type card = rank * suit
  * type hand = Empty | Hand of card * hand
    * Hand is a constructor defined within hand through the keyword 'of'
    * A type 'hand' is either 'Empty' or a combination a card to an existing hand
* Types are defined with lower case, and constructors are capitalized

## Lecture 5 • 2017/09/21
* Talked about lists. Up until now, the majority of our content is on syntax. I have made a page detailing some components [here](https://www.allanwang.ca/coding/ocaml/) <!-- TODO update -->

## Lecture 6 • 2017/09/22
* Worked on list recursion; see [notes](https://www.allanwang.ca/coding/ocaml/) <!-- TODO update -->
* Induction
  * Proof by structural induction on the list 'l'

## Lecture 7 • 2017/09/26
* Recursion examples; see next class

## Lecture 8 • 2017/09/28
* Binary Tree
  * type 'a tree = Empty | Node of 'a * 'a tree * 'a tree
  * Exercise – implement a function to verify that a tree is a binary search tree
* <details>
  <summary>In class code</summary>

  ```ocaml
  (* Tree definition *)
  type tree = Empty | Node of 'a * 'a tree * 'a tree
  
  
  (*
    Element insertion in a Binary Search Tree
    Note that elements are Nodes containing a key-value pair
    ('a * 'b) -> ('a * 'b) tree -> ('a * 'b) tree
   *)
  
  let rec insert ((x, dx) as e) t = match t with
    | Empty -> Node (e, Empty, Empty)
    | Node (((y, dy) as f), l, r) ->
      if x = y then Node (e, l, r)
      else if x < y then Node (f, insert e l, r)
      else Node (f, l, insert e r)
  
  (*
    Element lookup in a BST
    Takes in the key and a tree, and returns the value if it exists
    'a -> '('a * 'b) tree -> 'b option'
   *)
  
  let rec lookup x t = match t with
    | Empty -> None
    | Node ((y, dy), l, r) ->
      if x = y then Some dy
      else lookup x (if x < y then l else r)
  
  
  (*
    Collection function to convert a tree into a list with infix ordering
   *)
  let rec collect t = match t with
    | Empty = []
    | Node (x, l, r) -> (collect l) @ [x] @ (collect r)
  ```
  <details>
* Theorem: For all trees t, keys x, and data dx, lookup x (insert (x, dx) t) &rArr;* Some dx
  * Proof by structural induction
    * Case t = Empty
      * lookup x (insert (x, dx) Empty) &rArr; lookup x (Node ((x, dx), Empty, Empty) &rArr; Some dx
    * Case t = Node ((y, dy), l, r)
      * Induction Hypothesis 1 – For all x, dx, lookup x (insert (x, dx) l) &rArr;* Some dx
      * Induction Hypothesis 2 – For all x, dx, lookup x (insert (x, dx) r) &rArr;* Some dx
      * Show that insertion and lookup lead to the IH in all cases

## Lecture 9 • 2017/09/29
* Higher order functions
  * Programs can be short & compact
  * Programs are reusable
* Functions are first class – can be passed as parameters and returned as a result
* <details>
  <summary>In class code</summary>

  ```ocaml
  (*
      Given function and range,
      compute sum of given function applied to each number in given range
   *)
  
  let rec sum f (a, b) =
    if a > b then 0
    else f(a) + sum f(a + 1, b)
  
  let sumInts (a, b) =
    let id x = x in
    sum id (a, b)
  
  (* We may use anonymous functions *)
  let sunSquare (a, b) = sum (fun x -> x * x) (a b)
  
  (* We may also declare functions outside and use pattern matching
     functions take only one argument *)
  (function 0 -> 0 | n -> n + 1)
  (* Which is equivalent to *)
  (fun x -> match x with 0 -> 0 | n -> n + 1)
  ```
  </details>
* We can define functions on the fly without naming them by using anonymous functions

## Lecture 10 • 2017/10/03
* Currying
* Methods in languages like JavaScript are uncurried. (such as test(a, b, c)). All values need to be passed in at once, or the function cannot be called. The process of currying involves separating such inputs so that any number of them can be called to return a function needing only the remaining inputs ('a -> 'b -> 'c)

## Lecture 11 • 2017/10/05
* Lambda Calculus
  * Simple language consisting of variables, functions (&lambda;x.t) & function application
  * Can define all computable functions
  * Boolean encoding
    * T = &lambda;x.&lambda;y.x (keep first arg)
    * F = &lambda;x.&lambda;y.y (keep second arg)
* Recall currying: let curry f = (fun x y -> f (x,y))
* let deriv (f, dx) = fun x -> f(x +. dx) -. f x) /. dx

## Lecture 12 • 2017/10/06
* Midterm review

## Lecture 13 • 2017/10/12
* Midterm review

## Lecture 14 • 2017/10/13
* Expressions in OCaml have types, and evaluates to a value or diverges
* Today, we'll see that expressions may also have an <i>effect</i>
* <details>
  <summary>In class code</summary>

  ```ocaml
  let x = ref 0 (* Allocate reference x with initial value 0 *)
  
  a == b (* Compare by reference *)
  a = b (* Compare by content *)
  
  !x (* Read value *)
  x := 3 (* Update value *)
  
  let imperative_fact n =
      begin
          let result = ref 1 in
          let i  ref 0 in
          let rec loop () =
              if !i = n then ()
              else (i := !i + 1; result := !result * !i; loop ())
          in
          (loop (); !result)
      end
  ```
  </details>

## Lecture 15 • 2017/10/17
* <details>
  <summary>Types, values, & effects</summary>

  ```ocaml
  (* Types *)
  
  3 + 2
  (* int; 5; no effect *)
  
  55
  (* int; 55; no effect *)
  
  fun x -> x + 3 * 2
  (* int -> int; <fun> or fun x -> x + 2 * 3 *)
  
  ((fun x -> match x with [] -> true | y::ys -> false), 2.3 *. 2.0)
  (* ('a list -> bool) * float; (<fun>, 6.4); no effect *)
  
  let x = ref 3 in x := !x * 2
  (* unit = (); no effect; x is disposed (removed from stack after evaluation) *)
  
  
  fun x -> x := 3
  (* int ref -> unit; <fun>; effect: updated x to 3 *)
  
  (fun x -> x := 3) y
  (* unit = (); updates y : int ref to 3 *)
  
  fun x -> (x := 3; x)
  (* int ref -> int ref; updates x & returns reference *)
  
  fun x -> (x := 3; !x)
  (* int ref  int; updates x & returns value *)
  
  let x = 3 in print_string (string_of_int x)
  (* unit = (); prints 3 to screen *)
  
  (* --------------------
  Linked List Demo
  -------------------- *)
  
  type 'a rlist = Empty | RCons of 'a * ('a rlist) ref;;
  let l1 = ref (RCons (4, ref Empty));;
  let l2 = ref (RCons (5, l1));;
  (* The 'a rlist ref of l2 is l1, same address *)
  
  l1 := !l2;;
  (* We've created a circular list *)
  !l1;;
  (* int rlist = RCons(5, {contents = <cycle>}) *)
  ```
  </details>

## Lecture 16 • 2017/10/19
* <details>
  <summary>Object & closures</summary>

  ```ocaml
  (* Code transcript taken from Julian Lore
  https://github.com/julianlore/McGill-Resources/blob/master/COMP302/C302.pdf *)
  
  type 'a rlist = Empty | RCons of 'a * ('a rlist) ref
  
  let l1 = ref (RCons (4, ref Empty))
  let l2 = ref (RCons (5, l1));;
  
  l1 := !l2;;
  (* Value is (), effect is changing link to itself *)
  
  (* Append for regular lists *)
  let rec append l1 l2 = match l1 with
      | [] -> l2
      | x::xs -> x::(append xs l2)
  
  (* Append for rlist *)
  type 'a refList = ('a rlist) ref
  (* Return unit, as the "result" is the effect *)
  (* 'a refList -> 'a refList -> unit *)
  let rec rapp (r1 : 'a refList) (r2 : 'a refList) = match r1 with
      | {contents = Empty} -> r1 := !r2
      | {contents = RCons (x, xs)} -> rapp xs r2
  
  (* 'a refList -> 'a refList -> 'a rlist *)
  let rec rapp' (r1 : 'a refList) (r2 : 'a refList) = match r1 with
      | {contents = Empty} -> {contents = r2}
      | {contents = RCons (x, xs)} -> rapp' xs r2
  
  let r = ref (RCons (2, ref Empty))
  let r2 = ref (RCons(5, ref Empty));;
  
  let r3 = rapp' r r2;;
  r3;;
  rapp r r2;;
  r;;
  
  let (tick, reset) =
      let counter = ref 0 in
      (* Input is unit, always true. Not the same as void *)
      let tick () = (counter := !counter + 1 ; !counter) in
      let reset () = counter := 0 in
      (tick, reset);;
  
  (* Now we have 2 functions, tick and reset *)
  tick ();;
  tick ();;
  type counter_obj = {tick : unit -> int ; reset : unit -> unit}
  
  let makeCounter () =
      let counter = ref 0 in
      {tick = (fun () -> counter := !counter + 1 ; !counter);
      reset = (fun () -> counter := 0)};;
  
  (* global variable *)
  let global_counter = ref 0
  let makeCounter' () =
      let counter = ref 0 in
      {tick = (fun () -> counter := !counter + 1 ; global_counter := !counter ; !counter);
      reset = (fun () -> counter := 0)};;
  
  let c = makeCounter ();;
  c.tick ();;
  c.tick ();;
  let d = makeCounter ();;
  d.tick ();;
  c.tick ();;
  d.reset ();;
  ```
  </details>

## Lecture 17 • 2017/10/20
* Exceptions...
  * Force you to consider exceptional cases
  * Allows you to segregate special cases from other cases (avoids clutter)
  * Diverts control flow
  * Eg 3/0 raises an exception Division_by_zero

## Lecture 18 • 2017/10/24
* Backtracking
  * Algorithm that finds solutions incrementing, abandoning partial candidates as soon as it deems it cannot lead to a successful solution
  * Important tool to solve constraint satisfaction problems such as cross-words, puzzles, Sudoku, etc
* <details>
  <summary>Code</summary>

  ```ocaml
  (* Warm up; printing int list *)
  let listToString l = match l with
      | [] -> ""
      | l -> let rec toString l' = match l' with
          | [h] -> string_of_int h
          | h::t -> string_of_int h ^ ", " ^ toString t
          in
          toString l
  
  (* With backtracking, given list of coins (in descending order) and amount, see if we can return exact change*)
  exception Change
  
  let rec change coins amt =
      if amt = 0 then []
      else (match coins with
              | [] -> raise Change
              | coin :: cs ->
                  (* skip coin as it is too big *)
                  if coin > amt then change cs amt
                  (* try to include current coin, and skip if fail *)
                  else try coin :: (change coins (amt - coin)) with Change -> change cs amt
      )
  
  let change' coins amt =
      try Some (change coins amt) | with Change -> None
  ```
  </details>

## Lecture 19 • 2017/10/26
* Modules
  * Control complexity of developing & maintaining software
  * Split large programs into separate piece
  * Name space separation
  * Allows for separate compilation
  * Incremental development
  * Clear specifications at module boundaries
  * Programs are easier to maintain & reuse
  * Enforces abstractions
  * Isolates bugs
* Module Types
  * Allows you to hide information
  * Implementations can be more specific than the actual module type
* May use the open keyword to use module methods without specifying module name
* <details>
  <summary>Code</summary>

  ```ocaml
  module type STACK =
      sig
          type stack
          type el
          val empty : unit -> stack
          val is_empty : stack -> bool
          val pop : stack -> stack option
          val push : el -> stack -> stack
          (* val push : int -> stack -> stack *)
          (* cannot be el -> stack -> stack as 1 isn't a Stack.el *)
          (* May use further abstractions through creation functions, but that wasn't covered in class *)
      end
  
  (* Implementation *)
  module Stack : (STACK with type el = int) =
      struct
          type el = int
          type stack = int list
          let empty () : stack = []
          let push i ( s : stack) = i :: s
          let is_empty s = match s with
              | [] -> true
              | _::_ -> false
          let pop s = match s with
              | [] -> None
              | _::t -> Some t
          let top s = match s with
              | [] -> None
              | h :: _ -> Some h
          let rec length s acc = match s with
              | [] -> acc
              | x::t -> length t 1 + acc
      end
  ```
  </details>

## Lecture 20 • 2017/10/27
* More on modules

## Lecture 21 • 2017/10/31
* Continuation
  * Representation of execution state of program at certain point in time
  * Save current state of execution into object & restore state from object later on to resume execution
  * Base case – called continuation
  * Recursive case – build up computation that still needs to be done
* <details>
  <summary>Code</summary>

  ```ocaml
  (* append: 'a list -> 'a list -> 'a list *)
  let rec append l k = match l with
      | [] -> k
      | h :: t -> h :: (append t k)
  
  (* Tail Recursive *)
  let rec app_tl l k c = match l with
      | [] -> c k (* Call continuation with stack k *)
      | h :: t -> app_tl t k (fun r -> c (h :: r))  
  ```
  </details>