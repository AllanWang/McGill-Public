(* 
	Test code for hw3 - Comp 302
	
	*Warning* - I have no prior experience with OCaml.
	If you encounter an issue that is not obviously solvable, let me know;
	I may have made a mistake!
	To use this, put this file in the same drectory as your hw1.ml,
	launch ocaml, and execute:
	```
	#use "hw3.ml";;
	#use "hw3_test.ml";;
	```
	Allan Wang

	************************************************

	Clarification for a3q1
	"Max is the maximum number that if it is in the list it should be printed.
	evens 6 should print 6, fib 21 should print 21 while fib 22 should end at 21. And in the pascal case it should be the number of rows that are printed"
	- Francisco Ferreira
	
*)

exception Oops of string

let y cond msg = if not cond then (print_endline "\n\n-----Error-----"; raise (Oops msg));;

let eq' (a : 'a) (b : 'a) msg = y (a = b) msg;;

let eq_op a b msg = try eq' a (b()) msg with Assert_failure _ -> print_endline "Skipping optional check";;

let n cond msg = y (not cond) msg;;
	
let neq' (a : 'a) (b : 'a) msg = n (a = b) msg;;
	
let p msg =
	print_endline "Success!\n\n--------------------";
	print_endline msg;
	print_endline "--------------------";;
  
print_endline "--------------------\nTesting Q1\n--------------------";;

eq' (evens 3) [0;2] "evens 3 failed";
eq' (evens 8) [0;2;4;6;8] "evens 8 failed";

eq' (fib 1) [1;1] "fib 1 failed (should include 1s)";
eq' (fib 13) [1;1;2;3;5;8;13] "fib 13 failed (should include 13)";
eq' (fib 100) [1; 1; 2; 3; 5; 8; 13; 21; 34; 55; 89] "fib 100 failed";

eq' (pascal 3) [[1]; [1; 1]; [1; 2; 1]] "pascal 3 failed";
eq' (pascal 10) [[1]; [1; 1]; [1; 2; 1]; [1; 3; 3; 1]; [1; 4; 6; 4; 1]; 
[1; 5; 10; 10; 5; 1]; [1; 6; 15; 20; 15; 6; 1]; [1; 7; 21; 35; 35; 21; 7; 1]; 
[1; 8; 28; 56; 70; 56; 28; 8; 1]; [1; 9; 36; 84; 126; 126; 84; 36; 9; 1]] "pascal 10 failed";

p "Testing zip (extra)";;

let l = [(1,5);(2,6);(3,7)];;

eq_op l (fun () -> zip' [1;2;3] [5;6;7]) "zip same size lists failed";

eq_op l (fun () -> zip' [1;2;3;4] [5;6;7]) "zip different size lists failed";

p "Testing Q2 - memo_one";;

let time = fun () -> (print_endline (string_of_float (Sys.time())));;

let ugly' = memo_one ugly;;
let fast = (fun v -> let i = Sys.time() in ugly' v; y (Sys.time() -. i < 0.1) "Execution was perhaps too slow");;
let slow = (fun v -> let i = Sys.time() in ugly' v; y (Sys.time() -. i > 0.1) "Execution was perhaps too fast");;

time();
fast 3;
slow 9;
fast 9;
fast 3;
slow 9;
time();

p "Testing Q2 - memo_many";;

let ugly' = memo_many 3 ugly;;
let fast = (fun v -> let i = Sys.time() in ugly' v; y (Sys.time() -. i < 0.1) "Execution was perhaps too slow");;
let slow = (fun v -> let i = Sys.time() in ugly' v; y (Sys.time() -. i > 0.1) "Execution was perhaps too fast");;

print_endline "Note: I am assuming that when a call is made, it will renew its position in the queue";

(* The "cache queue" will be written with the functions *)
(* For this example, caches enter from the right and exit from the left *)

time();
(* [] *)
slow 9; 
(* [9] *)
fast 9;
(* [9] *)
fast 1;
(* [9;1] *)
fast 9;
(* [1;9] *)
fast 2;
(* [1;9;2] *)
fast 9;
(* [1;2;9] *)
fast 3;
(* [2;9;3] *)
fast 4;
(* [9;3;4] *)
fast 9;
(* [3;4;9] *)
fast 1;
(* [4;9;1] *)
fast 2;
(* [9;1;2] *)
fast 3;
(* [1;2;3] *)
slow 9;
(* [2;3;9] *)
fast 9;
(* [2;3;9] *)
time();

p "Testing Q3";;

let l = [2;3;4;5];;
let c = cons 2 (cons 3 (cons 4 (singl 5)));;

let eq'' a b msg = eq' (to_list a) (to_list b) msg;;
let eq_op'' a b msg = try eq'' a (b()) msg with Assert_failure _ -> print_endline "Skipping optional check";;

eq'' (cons 2 None) (singl 2) "Failed for cons w/ None circlist";

eq'' c (from_list l) "Failed for sequential cons";

eq' 4 (length c) "length failed";

eq'' c (from_list (to_list (from_list l))) "from_list to_list mismatch failed";

eq'' (from_list (List.rev l)) (rev (from_list l)) "rev failed";

p "Testing extra credit map";;

eq_op'' (from_list [4;5;6;7]) (fun () -> map ((+) 2) (from_list l)) "Failed to add 2 to each item in circlist";

p "Testing extra credit eq";;

let y l1 l2 = try y (eq (from_list l1) (from_list l2)) "eq failed" with Assert_failure _ -> print_endline "Skipping optional check";;
let n l1 l2 = try n (eq (from_list l1) (from_list l2)) "eq failed" with Assert_failure _ -> print_endline "Skipping optional check";;

y [1;2;3] [1;2;3];
y [1;2;3] [2;3;1];
n [1;2;3] [3;2;1];
y [1] [1;1;1;1];
y [1;2;1;2] [1;2;1;2;1;2];
y [1;2;2;1;2;2] [2;1;2;2;1;2;2;1;2];
n [1;2;3;1] [1;2;3];

print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;