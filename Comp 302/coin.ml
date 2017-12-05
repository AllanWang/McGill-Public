(* Given a list of coins in descending order and a total, 
   return the smallest possible list of coins giving the exact total
   Repetition is allowed *)

module type Change =
sig
  val change: int list -> int -> int list option
end

module BackTrack : Change =
struct

  exception BackTrack

  let change coins amt =
    (* Backtracking involves the use of exceptions to stop a failing execution *)
    let rec change' coins' amt' =
      if amt' = 0 then []
      else (match coins' with
          | [] -> raise BackTrack
          | coin' :: cs' ->
            (* skip coin as it is too big *)
            if coin' > amt' then change' cs' amt'
            (* try to include current coin, and skip if fail *)
            else try coin' :: (change' coins' (amt' - coin')) with BackTrack -> change' cs' amt'
        )
    in
    try Some (change' coins amt) with BackTrack -> None
end

module Continuation : Change =
struct
  let change coins amt =
    (* Continuation involves handling output using other functions
       For the sake of this example, we have two handlers,
       one for success and one for errors *)
    let rec change' coins' amt' (cont_succ' : int list -> 'a) (cont_err' : unit -> 'a) = 
      if amt' = 0 then cont_succ' []
      else match coins' with
        | [] -> cont_err' ()
        | coin' :: cs' ->
          if coin' > amt' then change' cs' amt' cont_succ' cont_err'
          else change' coins' (amt' - coin') 
              (fun list -> cont_succ' (coin' :: list)) 
              (fun () -> change' cs' amt' cont_succ' cont_err')
    in
    change' coins amt (fun x -> Some x) (fun () -> None)
end


