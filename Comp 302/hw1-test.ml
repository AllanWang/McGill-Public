(* 
	Test code for hw1 - Comp 302
	
	*Warning* - I have no prior experience with OCaml.
	If you encounter an issue that is not obviously solvable, let me know;
	I may have made a mistake!

	To use this, put this file in the same drectory as your hw1.ml,
	launch ocaml, and execute:
	```
	#use "hw1.ml";;
	#use "hw1-test.ml";;
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
	
	
print_endline "--------------------\nTesting predefined functions\n--------------------";;
y (cmp pi 3.1415) "The pi value was changed";
y (positive 1.0) "Positive was changed";
n (positive 0.0) "Positive was changed";

p "Testing well formed sides";;
n (well_formed_by_sides (0.0, 1.0, 1.0)) "All sides must be positive";
n (well_formed_by_sides (1.0, 0.0, 1.0)) "All sides must be positive";
n (well_formed_by_sides (1.0, 1.0, 0.0)) "All sides must be positive";
n (well_formed_by_sides (2.0, 1.0, 1.0)) "a >= b + c";
n (well_formed_by_sides (1.0, 2.0, 1.0)) "b + a >= c";
n (well_formed_by_sides (1.0, 1.0, 2.0)) "c >= a + b";


p "Testing triangle creations";;
let e (a, b, c : tr_by_sides) =
	a = b && b = c;;
let s (a, b, c : tr_by_sides) =
	a <> b && b <> c && a <> c;;
let i (t : tr_by_sides) =
	not (e t) && not (s t);;
y (e (create_triangle Equilateral 1.0)) "Failed to create equilateral triangle";
y (i (create_triangle Isosceles 1.0)) "Failed to create isosceles triangle";;

let scaleneTest = (create_triangle Scalene 1.0);;
y (s scaleneTest) "Failed to create scalene triangle";;

let s2 a =
	y (s (create_triangle Scalene (a ** 2.0 /. 2.0))) "You may be missing a special case for Scalene";;
let s3 (a, b, c : tr_by_sides) =
	s2 a;
	s2 b;
	s2 c;;

s3 scaleneTest;
	
p "Testing well formed angles";;
y (well_formed_by_angle (2.0, 2.0, 1.0)) "Angle 1.0 should be valid";
n (well_formed_by_angle (2.0, 2.0, pi)) "Angle pi should not be valid";

p "Testing side to angle";;
eq (sides_to_angle (3.0, 4.0, 5.0)) (Some (3.0, 4.0, pi /. 2.0)) "3 4 5 triangle should result in (3, 4, pi/2)";
eq (sides_to_angle (-1.0, 2.0, 1.0)) None "Triangles cannot have negative sides";
eq (sides_to_angle (1.0, 2.0, 1.0)) None "Invalid triangle cannot be converted";

p "Testing angle to side";;
eq (angle_to_sides (3.0, 4.0, pi /. 2.0)) (Some (3.0, 4.0, 5.0)) "3 4 pi/2 triangle should result in 3 4 5";
eq (angle_to_sides (1.0, 2.0, pi *. 2.0)) None "Invalid triangle cannot be converted";

p "Testing even";;
y (even 2) "2 is an even number";
n (even 1343) "1343 is an odd number";
eq (evens_first [1;2;3;4;5;6;7]) [2;4;6;1;3;5;7] "Failed to sort list with evens first";
eq (evens_first [1;3;5;7;3;2;2;4]) [2;2;4;1;3;5;7;3] "Failed to sort list with evens first";
eq (even_streak [1;3;5]) 0 "Even streak with odd sequence should be 0";
eq (even_streak [1;2;3;4;5]) 1 "Even streak failed";
eq (even_streak [1;2;2;3;4;5]) 2 "Even streak failed";
eq (even_streak [1;2;3;4;2;5]) 2 "Even streak failed";
eq (even_streak [1;2;2;2;3;2;3;4;2;5]) 3 "Even streak failed";

p "Testing nucleobase compression";;
eq (compress [A;A;A;A;A]) [(5, A)] "Nucleobase compression failed";
neq (compress [A;A;A;T;T;T;G;G;G;A]) [(3, T);(3,G);(3,A);(1,A)] "Your nucleobase values are mismatched";
eq (compress [A;A;A;T;T;T;G;G;G;A]) [(3, A);(3,T);(3,G);(1,A)] "Nucleobase compression failed";

p "Testing nucleobase decompression";;
eq (decompress [(3, A);(2,T)]) [A;A;A;T;T] "Decompression failed";
y res_3_4 "Sample DNA was not returned after going through compression and decompression";

print_endline "Success!\n\n----------\nEnd of tester; No errors found!\n----------";;