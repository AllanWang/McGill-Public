(* 
	Test code for practice - Comp 302
	
	*Warning* - I have no prior experience with OCaml.
	If you encounter an issue that is not obviously solvable, let me know;
	I may have made a mistake!

	Given that we don't have specified function names,
	you may have to add extra functions to include that.

	For the sake of this tester code, functions should be named
	q1, q2, ... q8.
	In my case, my first fun is compute_results
	So I can add the line:

	let q1 = compute_results

	So the test code recognizes it.


	To use this, put this file in the same drectory as your practice.ml,
	launch ocaml, and execute:
	```
	#use "practice.ml";;
	#use "practice_test.ml";;
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
	
(* Global definitons *)
let bets = [(2, Red);(3, Black);(4, Black)];;
let red_only = [(2, Red);(3, Red);(4, Red)];;
let black_only = [(2, Black);(3, Black);(4, Black)];;
let no_bets = [];;

print_endline "--------------------\nQ1\n--------------------";;

eq (q1 bets (Some Red)) [4;0;0] "Q1 failed for red bets";
eq (q1 bets (Some Black)) [0;6;8] "Q1 failed for black bets";
eq (q1 bets None) [0;0;0] "Q1 failed for colourless bet";

p("Q2");;

eq (q2 bets (Some Red)) [(2, Red)] "Q2 failed for red bets";
eq (q2 bets (Some Black)) [(3, Black);(4, Black)] "Q2 failed for black bets";
eq (q2 no_bets None) [] "Q2 failed for empty & colourless bet";
eq (q2 bets None) [] "Q2 failed for colourless bet";

p("Q3");;

eq (q3 no_bets (Some Red)) 0 "Q3 failed for no bets";
eq (q3 bets (Some Red)) 4 "Q3 failed for red bets";
eq (q3 black_only (Some Black)) 18 "Q3 failed for all black bets";

p("Q4");;

eq (q4 bets None) false "Q4 failed for colourless bets";
eq (q4 bets (Some Red)) false "Q4 failed for red bets";
eq (q4 black_only (Some Black)) true "Q4 failed for black only bets";

p("Q5");;

eq (q5 bets None) false "Q5 failed for colourless bets";
eq (q5 red_only (Some Black)) false "Q5 failed for red only bets";
eq (q5 black_only (Some Black)) true "Q5 failed for black only bets";
eq (q5 bets (Some Black)) true "Q5 failed for generic bets";

p("Q6");;

eq (q6 bets (Some Red)) 4 "Q6 failed for generc bets";
eq (q6 red_only (None)) 0 "Q6 failed for red only bets";
eq (q6 black_only (Some Black)) 8 "Q6 failed for black only bets";

p("Q7");;

eq (q7 no_bets (Some Red)) 0 "Q7 failed for no bets";
eq (q7 bets (Some Red)) 5 "Q7 failed for generic bets";
eq (q7 black_only (Some Black)) (-9) "Q7 failed for black only bets";

p("Q8");;

eq (q8 bets None) bets "Q8 failed for colourless bets";
eq (q8 bets (Some Red)) [(3, Black);(4, Black);(2, Red)] "Q8 failed for generic bets";
eq (q8 black_only (Some Black)) black_only "Q8 failed for black only bets";

print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;