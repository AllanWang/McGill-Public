(* Part 1: define a function that computes the parity of a list of
   booleans.

   What we want is a function even_parity such as even_parity l
   returns a boolean that combined with the elements of l the 
   number of 1’s (true) is even.
   This is a simple but important algorithm in data communication, its
   purpose is to detect errors (one bit flips). It is very easy to
   implement in circuit but it is not very reliable.
 *)

let rec even_parity = function
  | [] -> false
  | true::xs -> not (even_parity xs)
  | false::xs -> even_parity xs

(* This version is very natural but it is not tail recursive. Let's
   make the tail recursive version. *)

let even_parity_tr l =
  let rec parity p = function
    | [] -> p
    | p'::xs -> parity (p<>p') xs
  in
  parity false l

(* Part 2: Now prove that both functions are equivalent. You will need to use facts about the <> (XOR) operation *)

let ex_1 = [true]
let ex_2 = [true; true]
let ex_3 = [false; true; true; false; true]

let t_1 = even_parity ex_1 = even_parity_tr ex_1
let t_2 = even_parity ex_2 = even_parity_tr ex_2
let t_3 = even_parity ex_3 = even_parity_tr ex_3

(* High order - croupier for simplified roulette *)

(* We have a simplified roulette, where we have only two colours that
   we can bet but if zero comes out, everyone loses *)

type colour = Red | Black        (* The two colours we can bet on *)

type result = colour option      (* The result of a run, it could be one of the colours or no colour if zero came up *)

type bet = int * colour          (* The bet amount and to what colour *)


(* It is simple to see who won *)
let compute (am, col : bet) : result -> int = function
  | None -> 0
  | Some col' -> if col = col' then am * 2 else 0

(*
Solve all these questions without using recursion or pattern
matching on lists, but instead just use the HO functions we saw
in class.
 *)

(* Q1:  given a list of bets compute the results *)
(* Reworded: Given a list of bets and a result, return a list of money won *)
let compute_results bets result = 
  bets |> List.map (fun bet -> compute bet result)

(* This is used to map the function to one that the test code understands *)
let q1 = compute_results

(* Q2: given a list of bets and a result compute a list of winning bets *)
let winning_bets bets result =
  bets |> List.filter (fun bet -> compute bet result > 0)

let q2 = winning_bets

(* Q3: given a list of bets and a result compute how much money the casino needs to pay back *)

let bet_sum bets result =
  bets |> List.fold_left (fun sum bet -> sum + (compute bet result)) 0

let q3 = bet_sum

(* Q4: given a list of bets and a result compute if everyone won *)

let everyone_won bets result =
  bets |> List.for_all (fun bet -> compute bet result > 0)

let q4 = everyone_won

(* Q5: given a list of bets and a result compute if someone won *)

let someone_won bets result =
  bets |> List.exists (fun bet -> compute bet result > 0)

let q5 = someone_won

(* Q6: given a list of bets return the highest winning *)

let highest_winning bets result =
  bets |> List.fold_left (fun m bet -> max (compute bet result) m) 0

let q6 = highest_winning

(* Level-up (a bit more complicated) *)

(* Q7: given a list of bets and a result compute the balance for the casino, how much it made *)

let casino_balance bets result =
  bets |> List.fold_left (fun net (am, col as bet) -> net + am - (compute bet result)) 0

let q7 = casino_balance

(* Ninja level  *)

(* Q8: Can you sort the results by the amount they made? *)
(* Reworded: Given a list of bets and a result, return the bets in ascending order of profit 
There is more than one way to do this
I chose to map each bet to a (bet, am) pair so the amount calculation is only called once per bet. 
If the function were very intensive, there would be performance increases (at the expense of a little bit of memory) *)
let sorted_bet_results bets result =
  bets |> List.map (fun bet -> (bet, compute bet result)) |> List.sort (fun (bet1, am1) (bet2, am2) -> am1 - am2) |> List.map (fun (bet, am) -> bet)

let q8 = sorted_bet_results  
