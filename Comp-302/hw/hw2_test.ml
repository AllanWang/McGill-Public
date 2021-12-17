(* 
	Test code for hw1 - Comp 302
	
	*Warning* - I have no prior experience with OCaml.
	If you encounter an issue that is not obviously solvable, let me know;
	I may have made a mistake!

	To use this, put this file in the same drectory as your hw1.ml,
	launch ocaml, and execute:
	```
	#use "hw2_q1.ml";;
	#use "hw2_test.ml";;
	```
	
	Allan Wang
*)

exception Oops of string

let y cond msg =
	if not cond then begin
		print_endline "\n\n-----Error-----";
		raise (Oops msg)
	end;;
	
let eq (a : 'a) (b : 'a) msg =
	y (a = b) msg;;
	
let n cond msg =
	y (not cond) msg;;
	
let neq (a : 'a) (b : 'a) msg =
	n (a = b) msg;;
	
let p msg =
	print_endline "Success!\n\n--------------------";
	print_endline msg;
	print_endline "--------------------";;
	
	
print_endline "--------------------\nTesting Tautologies\n--------------------";;
n (taut(Atom("A"))) "A is not a tautology";
y (taut(Or(Atom("A"), Not(Atom("A"))))) "A || A' is a tautology";
n (taut(impl(Atom("P"), Atom("Q")))) "(P => Q) is not a tautology";
y (taut(Or(impl(Atom("P"), Atom("Q")), impl(Atom("Q"), Atom("P"))))) "(P => Q) || (Q => P) is a tautology";

print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;