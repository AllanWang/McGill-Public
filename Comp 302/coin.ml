(* Given a list of coins in descending order and a total, return the smallest possible list of coins giving the exact total
   Repetition is allowed *)

exception NoExactChange

module type Change =
sig
  val change: int list -> int -> int list
end

module BackTrack : Change =
struct

  exception BackTrack
  let rec change coins amt =
    if amt = 0 then []
    else (match coins with
        | [] -> raise NoExactChange
        | coin :: cs ->
          (* skip coin as it is too big *)
          if coin > amt then change cs amt
          (* try to include current coin, and skip if fail *)
          else try coin :: (change coins (amt - coin)) with BackTrack -> change cs amt
      )
end

module Continuation : Change =
struct
  let change coins amt =
    let change' coins' amt' (cont_succ' : int list -> int list) (cont_err' : unit -> int list) = 
      match coins' with
      | [] -> cont_err' ()
      | 
    in
    (* change' coins amt (fun x -> raise NoExactChange) *)
end


