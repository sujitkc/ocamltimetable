(* create a new empty dict *)
let make () = []

(* get the list of keys in dict d *)
let keyset d = List.map (fun (x, _) -> x) d

(* Add a key value pair (k, v) to the given dict d. *)
let rec add k v d =
  match d with
    [] -> [(k, [v])]
  | (k', l) :: t -> 
    if k = k' then
      if (List.mem v l = false) then
        (k, v :: l) :: t
      else
       d
    else
      (k', l) :: (add k v t)

(* Add a list vs of values for a given key k to a dict d. *)
let add_values k vs d =
  let rec loop k vs d =
    match vs with
      [] -> d
    | v :: vs' -> loop k vs' (add k v d)
  in
  loop k vs d

(* utility function to allow creating a dict out of a list representation. *)
let rec of_list l =
  match l with
    [] -> make ()
  | (k, vs) :: t -> let d = of_list t in add_values k vs d

let string_of_key = string_of_int
let string_of_values values =
  let los = List.map string_of_value values in
  let s = List.fold_left (fun x y -> x ^ ";" ^ y) "" los in
  "[" ^ s ^ "]"

let string_of_dict d =
  let los = List.map
        (fun (k, v) -> "(" ^ (string_of_key k) ^ ", " ^ (string_of_values v) ^ "); ")
        d in
  let s = List.fold_left (fun x y -> x ^ y) "" los in
  "[" ^ s ^ "]"

(* Add v as key with k as value to d *)  
let add_value_as_key k v d = add v k d

(* Add all values in vs as keys with k as value *)
let rec add_values_as_keys k vs d =
    match vs with
      [] -> d
    | v' :: vs' -> add_value_as_key k v' (add_values_as_keys k vs' d)

(* invert the dict d *)
let rec invert d =
  match d with
    [] -> make ()
  | (k, vs) :: t -> add_values_as_keys k vs (invert t) 

let t1 () =
  let d1 = make () in
  let d2 = add 1 2 d1 in
  let d3 = add 3 4 d2 in
  let d4 = add 1 5 d3 in
  print_endline (string_of_dict d4)

let t2 () =
  let d = of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  print_endline (string_of_dict d)

let t3 () =
  let d = of_list [(1, [2; 3]); (4, [3; 6; 7]); (8, [7])] in
  print_endline (string_of_dict (invert d))

let t4 () =
  let d1 = add_values_as_keys 1 [2; 3] (make ()) in
  let d2 = add_values_as_keys 4 [2; 5] d1 in
  print_endline (string_of_dict d2)
