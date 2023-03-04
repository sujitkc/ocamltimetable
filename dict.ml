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

let rec get k d =
  match d with
    [] -> None
  | (k', vs) :: t -> if k = k' then Some(vs) else (get k t)

(* Add a list vs of values for a given key k to a dict d. *)
let add_values k vs d =
  List.fold_left (fun d' v -> add k v d') d vs

(* utility function to allow creating a dict out of a list representation. *)
let of_list l =
  List.fold_left (fun d' (k, vs) -> add_values k vs d') (make ()) l

let string_of_key = string_of_int
let string_of_value = string_of_int
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
   List.fold_left (fun d' v -> add_value_as_key k v d') d vs 

(* invert the dict d *)
let rec invert d =
  let ks = keyset d in
  let rec loop ks d' =
    match ks with
      [] -> d'
    | k :: ks' ->
        let vsoption = get k d in
        begin
          match vsoption with
            None -> failwith "invert: Something went wrong!"
          | Some(vs) ->
              let d'' = add_values_as_keys k vs d' in
              loop ks' d''
        end
  in
  loop ks (make ())

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

let test_key k d =
  let vs = get k d in
  match vs with
    None -> print_endline "key not found."
  | Some(vs') -> print_endline ("d[" ^ (string_of_key k) ^ "] = " ^ (string_of_values vs'))

let t5 () =
  let d = of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])]
  and k = 1 in
  test_key k d

let t6 () =
  let d = of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])]
  and k = 5 in
  test_key k d

let t7 () =
  let d = of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  let d1 = add_values 1 [10; 11] d in
  print_endline (string_of_dict d1)
