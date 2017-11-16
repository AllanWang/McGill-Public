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

	The tests are not varied, but they should cover most of the general cases.
	Using different numbers typically shouldn't affect the response.

	There are also some additional tests for those who are able to compute operations
	in O(n) time.
	
*)

#use "hw4.ml";;

exception Oops of string

let warned = ref false

let y cond msg = if not cond then (print_endline "\n\n-----Error-----"; raise (Oops msg));;

let w cond msg = if not cond then (print_endline ("\n\n-----Warning-----\n" ^ msg ^ "\n\n"); warned := true);;

let eq (a : 'a) (b : 'a) msg = y (a = b) msg;;

let n cond msg = y (not cond) msg;;
	
let neq (a : 'a) (b : 'a) msg = n (a = b) msg;;

let approx_float a b delta = abs_float (a -. b) < delta;;

let eps_float a b = approx_float a b epsilon_float;;

let big_epsilon = 0.00000000000001;;

let time_snapshot = ref (0.0);;

let start_timer () = let now = Sys.time() in let _ = print_endline ("Time now: " ^ (string_of_float now)) in time_snapshot := now;;

let get_time () = let diff = Sys.time() -. !time_snapshot in let _ = print_endline ("Time diff: " ^ (string_of_float diff)) in diff;;
	
let p msg =
	print_endline "Success!\n\n--------------------";
	print_endline msg;
	print_endline "--------------------";;
  
print_endline "--------------------\nTesting Find Functions\n--------------------";;

let example = Node (7, [ Node (1, []); Node (2, [Node (16, [])]); Node (4, []); Node (9, []); Node (11, []); Node (15, [])]) ;; (* Just to be sure *)

y (try (let _ = find_e ((=) 123) example in false) with BackTrack -> true | _ -> false) "Failed to throw BackTrack exception";

eq (find_e ((=) 11) example) 11 "Did not return 11 with find_e 11";

eq (find ((=) 2) example) (Some 2) " Did not find 2 in example with find";

eq (find' ((=) 2) example) (Some 2) " Did not find 2 in example with find'";;

let even_act = find_all (fun x -> x mod 2 = 0) example;;

let even_exp = 16 + 2 + 4;;

y (List.fold_left (+) 0 even_act = even_exp) "Could not fetch even list through find_all";;

p "FractionArith";;

let f f1 op f2 f3 msg = y (FractionArith.eq (op (FractionArith.from_fraction f1) (FractionArith.from_fraction f2)) (FractionArith.from_fraction f3)) msg;;

let f_comp f1 op f2 msg = y (op (FractionArith.from_fraction f1) (FractionArith.from_fraction f2)) msg;;

f (1, 2) FractionArith.plus (1, 4) (3, 4) "1/2 + 1/4 = 3/4";;
f (1, 2) FractionArith.minus (2, 1) (-3, 2) "1/2 - 2 = -3/2";;
f (-3, 4) FractionArith.prod (99, 99) (3, -4) "-3/4 * 99/99 = -3/4";;
f (2, -3) FractionArith.div (5, -7) (14, 15) "-2/3 / -5/7 = 14/15";;
f_comp (3, 4) FractionArith.lt (4, 5) "3/4 < 4/5";;
f_comp (1, 8) FractionArith.ge (97, 8 * 97) "1/8 >= 97/(8 * 97)";;
f_comp (9999999999, 3) FractionArith.gt (3, 9999999999) "9999999999/3 > 3/9999999999; you may have overflow errors";;
f_comp (3, 9999999999) FractionArith.lt (9999999999, 3) "3/9999999999 < 9999999999/3; you may have overflow errors";;
f_comp (3, 1000005) FractionArith.eq (3, 1000005) "3/1000005 = 3/1000005";;

p "Newton-Raphson";;

module FloatN = Newton (FloatArith);;
module RationalN = Newton (FractionArith);;

let sqrtN n = FloatN.square_root (FloatArith.from_fraction (n, 1));;
let sqrtN_r n = RationalN.square_root (FractionArith.from_fraction (n, 1));;

let yN act exp tag = y (FloatArith.le (FloatArith.abs (FloatArith.minus act (FloatArith.from_fraction exp))) FloatArith.epsilon) (tag ^ " for FloatArith did not match actual value within epsilon bound; expected " ^ (FloatArith.to_string (FloatArith.from_fraction exp)) ^ ", actual " ^ (FloatArith.to_string act));;
let yN_r act exp tag = y (FractionArith.le (FractionArith.abs (FractionArith.minus act (FractionArith.from_fraction exp))) FractionArith.epsilon) (tag ^ " for FractionArith did not match actual value within epsilon bound; expected " ^ (FractionArith.to_string (FractionArith.from_fraction exp)) ^ ", actual " ^ (FractionArith.to_string act));;

let sqrt2 = sqrtN 2;;
let sqrt2_r = sqrtN_r 2;;
let sqrt2approx = (768398401, 543339720);;
let sqrt2tag = "sqrt(2)";;

yN sqrt2 sqrt2approx sqrt2tag;;
yN_r sqrt2_r sqrt2approx sqrt2tag;;

let sqrt4 = sqrtN 4;;
let sqrt4_r = sqrtN_r 4;;
let sqrt4approx = (2, 1);;
let sqrt4tag = "sqrt(4)";;

(* yN sqrt4 sqrt4approx sqrt4tag;; *)
(* yN_r sqrt4_r sqrt4approx sqrt4tag;; *)

p "nth";;

let c = constant 1;;
let i = real_of_int 7;;

eq (nth c 23) 1 "nth (constant 1) 23 = 1";;

p "q";;

eq (q c 0) 1 "q (constant 1) 0 = 1";;

eq (q c 10) 89 "q (constant 1) 10 = 89";;

start_timer();;
eq (q c 34) 9227465 "q (constant 1) 34 = 9227465";;
let fast = get_time() < 1.0;;

if not fast then print_endline "q was slow; skipping big tests" else (
	print_endline "q was fast; testing big tests";
	eq (q c 400) 4536716983099355453 "q (constant 1) 400 = 4536716983099355453";
);;

p "r";;

eq (r c 0) 1.0 "r (constant 1) 0 = 1.0";;

eq (r c 8) 1.61764705882352944 "r (constant 1) 8 = 1.61764705882352944";;

start_timer();;
eq (r c 32) 1.61803398874985871 "r (constant 1) 32 = 1.61803398874985871";;
let fast = get_time() < 1.0;;

if not fast then print_endline "r was slow; skipping big tests" else (
	print_endline "r was fast; testing big tests";
	eq (r c 400) 1.6180339887498949 "r (constant 1) 400 = 1.6180339887498949";
);;

p "error";;

eq (error c 3) 0.0666666666666666657 "error (constant 1) 3 = 0.0666666666666666657";;

eq (error c 10) 7.8027465667915107e-05 "error (constant 1) 10 = 7.8027465667915107e-05";;

eq (error i 1) infinity "error (real_of_int 7) 1 = infinity";;

p "rat_of_real";;

eq (rat_of_real c 0.000001) 1.61803444782168171 "rat_of_real (constant 1) 0.000001 = 1.61803444782168171";;

eq (rat_of_real i 0.000001) 7.0 "rat_of_real (real_of_int 7) 0.000001 = 7.0";;

p "r2 = real_of_rat (4.0 /. 3.0)"

let r2 = real_of_rat (4.0 /. 3.0);;

eq r2.head 1 "r2.head = 1";;

eq (r2.tail()).head 3 "(r2.tail()).head = 3";;

p "r3 = real_of_rat ((4.0 +. epsilon_float) /. 2.0)"

let r3 = real_of_rat ((4.0 +. epsilon_float) /. 2.0);;

eq r3.head 2 "r3.head = 2";;

let r3t = take 500 (r3.tail());;

y (List.for_all ((=) 0) r3t) "tail elements of r3 are not all 0s";;

(* To print r3 *)
(* List.iter (Printf.printf "%d ") (take 500 r3);; *)

p "Example Tests";;

let sqrt2 =
  {head = 1 ; tail = fun () -> constant 2};;
let sqrt_2_rat = rat_of_real sqrt2 1.e-5;;
let golden_ratio_rat = rat_of_real golden_ratio 1.e-5;;

(* To test the representation of rationals we can try this *)
let to_real_and_back n = rat_of_real (real_of_rat n) 0.0001;;

(* e1 should be very close to 10 (it is exactly 10 in the model solution) *)
let e1 = to_real_and_back 10.0;;

y (approx_float e1 10.0 big_epsilon) "Example e1 was not close to 10.0";;

(* this is the float approximation of pi, not the real number pi *)
let not_pi = 2. *. acos 0.;;

y (approx_float not_pi 3.14159265358979323 big_epsilon) "not_pi is not a good approximation of pi";;

(* This should share the same 4 decimals with not_pi *)
let not_pi' = to_real_and_back not_pi;;

y (approx_float not_pi not_pi' 0.0001) "4 decimals not shared between not_pi & not_pi'";;

if !warned then print_endline "End of tests\n\nSome warning were issued"
else print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;