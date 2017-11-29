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

	-------------------------------------------
	
*)

#use "hw5.ml";;

exception Oops of string

let warned = ref false;;

let y cond msg = if not cond then (print_endline "\n\n-----Error-----"; raise (Oops msg));;

let w cond msg = if not cond then (print_endline ("\n\n-----Warning-----\n" ^ msg ^ "\n\n"); warned := true);;

let eq (a : 'a) (b : 'a) msg = y (a = b) msg;;

let n cond msg = y (not cond) msg;;
	
let neq (a : 'a) (b : 'a) msg = n (a = b) msg;;

open E;;

module U =
struct
	let add a b = Primop (Plus, [Int a; Int b])
	let add' a b = Primop (Plus, [a; b])
	let sub a b = Primop (Minus, [Int a; Int b])
	let sub' a b = Primop (Minus, [a; b])
	let mul a b = Primop (Times, [Int a; Int b])
	let neg a = Primop (Negate, [Int a])
	let le a b = Primop (LessThan, [Int a; Int b])
	let eqi a b = Primop (Equals, [Int a; Int b])
	let eqb a b = Primop (Equals, [Bool a; Bool b])
	let ifelse cond yes no = If (cond, yes, no)
	let letin var e1 e2 = Let (Val (e1, var), e2)
	let let2in var1 var2 e1 e2 e3 = Let (Match (Pair (e1, e2), var1, var2), e3)
end;;

let s' = function | Int x -> string_of_int x | Bool x -> string_of_bool x | _ -> "NA";;

let e' exp act msg = let out = Eval.eval act in if exp <> out then raise (Oops ("Failed " ^ msg ^ "; Expected " ^ (s' exp) ^ "; Actually " ^ (s' out)));;

open U;;

(* Given examples *)

let x1 = ifelse (eqi 3 2) (add' (Int 5) (mul 3 5)) (add' (Int 1) (mul 3 5));;

e' (Int 16) x1 "if 3 = 2 then 5 + 3 * 5 else 1 + 3 * 5";;

let x2 = let2in "x" "y" (ifelse (le 3 0) (Int 5) (Int 4)) (Bool false) (ifelse (Var "y") (add' (Var "x") (Int 2)) (sub' (Var "x") (Int 2)));;

e' (Int 2) x2 "let (x, y) = (if 3 <= 0 then 5 else 4, false) in if y then x + 2 else x - 2";;

if !warned then print_endline "End of tests\n\nSome warnings were issued"
else print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;