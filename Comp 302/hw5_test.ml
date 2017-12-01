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

let rec s' = function 
	| Int x -> string_of_int x 
	| Bool x -> string_of_bool x 
	| Pair (x, y) -> "(" ^ (s' x) ^ ", "  ^ (s' y) ^ ")"
	| _ -> "NA";;

let e' name exp act msg = match (try Some (Eval.eval act) with | _ -> None) with
	| Some out -> if exp <> out then 
		raise (Oops ("Failed " ^ name ^ ": " ^ msg ^ "; Expected " ^ (s' exp) ^ "; Actually " ^ (s' out)))
	| None -> raise (Oops ("Failed " ^ name ^ ": " ^ msg ^ "; Expected " ^ (s' exp) ^ "; Actually EXCEPTION"));;

let e_fail' act msg = match (try Some (Eval.eval act) with | _ -> None) with
	| Some out -> raise (Oops ("Failed " ^ msg ^ "; Expected EXCEPTION; Actually " ^ (s' out)))
	| None -> ();;


let test0 = E.If (E.Primop (E.Equals, [E.Int 3; E.Int 2]), E.Primop (E.Plus, [E.Int 5; E.Primop (E.Times, [E.Int 3; E.Int 5])]), E.Primop (E.Plus, [E.Int 1; E.Primop (E.Times, [E.Int 3; E.Int 5])]));;

e' "test0" (Int 16) test0 "if 3 = 2 then 5 + 3 * 5 else 1 + 3 * 5";;


let test1 = E.Let (E.Val (E.Int 7, "x"), E.Int 9);;

e' "test1" (Int 9) test1 "let x = 7 in 9";;


let test2 = E.Let (E.Val (E.Int 7, "x"), E.Var "x");;

e' "test2" (Int 7) test2 "let x = 7 in x";;


let test3 = E.Let (E.Match (E.Pair (E.Int 3, E.Bool false), "x", "y"), E.If (E.Var "y", E.Primop (E.Plus, [E.Var "x"; E.Int 1]), E.Int 7));;

e' "test3" (Int 7) test3 "let (x, y) = (3, false) in if y then x + 1 else 7";;


let test4 = E.Let (E.Match (E.Pair (E.Int 3, E.Bool false), "x", "y"), E.Primop (E.Plus, [E.Var "x"; E.Int 1]));;

e' "test4" (Int 4) test4 "let (x, y) = (3, false) in x + 1";;


let test5 = E.Let (E.Match (E.Pair (E.Int 3, E.Bool false), "x", "y"), E.If (E.Bool false, E.Int 1, E.Int 2));;

e' "test5" (Int 2) test5 "let (x, y) = (3, false) in if false then 1 else 2";;


let test6 = E.Let (E.Val (E.Int 3, "z"), E.Let (E.Val (E.Int 7, "x"), E.Let (E.Val (E.Var "x", "y"), E.Var "z")));;

e' "test6" (Int 3) test6 "let z = 3 in let x = 7 in let y = x in z";;


let test7 = E.Let (E.Match (E.Pair (E.Int 3, E.Int 2), "x", "y"), E.Primop (E.Plus, [E.Var "x"; E.Var "y"]));;

e' "test7" (Int 5) test7 "let (x, y) = (3, 2) in x + y";;


let test8 = E.Let (E.Match (E.Pair (E.Bool false, E.Int 7), "x", "y"), E.If (E.Var "x", E.Int 1, E.Var "y"));;

e' "test8" (Int 7) test8 "let (x, y) = (false, 7) in if x then 1 else y";;


let test9 = E.Let (E.Match (E.Pair (E.Int 1, E.Int 2), "x", "y"), E.Let (E.Match (E.Pair (E.Var "x", E.Var "y"), "a", "b"), E.Primop (E.Plus, [E.Var "a"; E.Var "b"])));;

e' "test9" (Int 3) test9 "let (x, y) = (1, 2) in let (a, b) = (x, y) in a + b";;



if !warned then print_endline "End of tests\n\nSome warnings were issued"
else print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;