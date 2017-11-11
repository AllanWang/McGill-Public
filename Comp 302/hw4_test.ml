(* 
	Test code for hw4 - Comp 302
	
	*Warning* - I have no prior experience with OCaml.
	If you encounter an issue that is not obviously solvable, let me know;
	I may have made a mistake!
	To use this, put this file in the same drectory as your hw4.ml,
	launch ocaml, and execute:
	```
	ocaml hw4_test.ml
	```
	Allan Wang
	
*)

#use "hw4.ml";;

exception Oops of string

let y cond msg = if not cond then (print_endline "\n\n-----Error-----"; raise (Oops msg));;

let eq (a : 'a) (b : 'a) msg = y (a = b) msg;;

let n cond msg = y (not cond) msg;;
	
let neq (a : 'a) (b : 'a) msg = n (a = b) msg;;
	
let p msg =
	print_endline "Success!\n\n--------------------";
	print_endline msg;
	print_endline "--------------------";;
  
print_endline "--------------------\nTesting Q1\n--------------------";;

let example = Node (7, [ Node (1, []); Node (2, [Node (16, [])]); Node (4, []); Node (9, []); Node (11, []); Node (15, [])]) ;; (* Just to be sure *)

y (try (let _ = find_e ((=) 123) example in false) with BackTrack -> true | _ -> false) "Failed to throw BackTrack exception";

eq (find_e ((=) 11) example) 11 "Did not return 11 with find_e 11";

eq (find ((=) 2) example) (Some 2) " Did not find 2 in example with find";

eq (find' ((=) 2) example) (Some 2) " Did not find 2 in example with find'";;

let even_act = find_all (fun x -> x mod 2 = 0) example;;

let even_exp = [16;2;4];;

y (even_act = even_exp || even_act = List.rev even_exp) "Could not fetch even list through find_all";;

p "FractionArith";;

let f f1 op f2 f3 msg = y (FractionArith.eq (op (FractionArith.from_fraction f1) (FractionArith.from_fraction f2)) (FractionArith.from_fraction f3)) msg;;

let f_comp f1 op f2 msg = y (op (FractionArith.from_fraction f1) (FractionArith.from_fraction f2)) msg;;

f (1, 2) FractionArith.plus (1, 4) (3, 4) "1/2 + 1/4 = 3/4";;
f (1, 2) FractionArith.minus (2, 1) (-3, 2) "1/2 - 2 = -3/2";;
f (-3, 4) FractionArith.prod (99, 99) (3, -4) "-3/4 * 99/99 = -3/4";;
f (2, -3) FractionArith.div (5, -7) (14, 15) "-2/3 / -5/7 = 14/15";;
f_comp (3, 4) FractionArith.lt (4, 5) "3/4 < 4/5";;
f_comp (1, 8) FractionArith.ge (97, 8 * 97) "1/8 >= 97/(8 * 97)";;
f_comp (3, 1000005) FractionArith.eq (3, 1000005) "3/1000005 = 3/1000005";;

p "Newton-Raphson";;

module FloatN = Newton (FloatArith);;
module RationalN = Newton (FractionArith);;
let sqrt2 = FloatN.square_root (FloatArith.from_fraction (2, 1));;
let sqrt2_r = RationalN.square_root (FractionArith.from_fraction (2, 1));;
let sqrt2approx = (768398401, 543339720);;

y (FloatArith.le (FloatArith.abs (FloatArith.minus sqrt2 (FloatArith.from_fraction sqrt2approx))) FloatArith.epsilon) "sqrt(2) for FloatArith did not match actual value within epsilon bound";;

y (FractionArith.le (FractionArith.abs (FractionArith.minus sqrt2_r (FractionArith.from_fraction sqrt2approx))) FractionArith.epsilon) "sqrt(2) for FractionArith did not match actual value within epsilon bound";;

print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;