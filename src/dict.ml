(* create a new empty dict *)
let make_dict () = []

(* get the list of keys in dict d *)
let keyset d = List.map (fun (x, _) -> x) d

let has_key k d = List.mem k (keyset d)

let add_key k d = if (has_key k d) then d else ((k, []) :: d)

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

(* List of all keys mapped to value v *)
let keys_of_value v d =
  let keys = keyset d in
  List.filter
    (fun k ->
       match get k d with
         None -> false
       | Some(vs) -> List.mem v vs
    ) keys

(* Add a list vs of values for a given key k to a dict d. *)
let add_values k vs d =
  let d1 = add_key k d in
  List.fold_left (fun d' v -> add k v d') d1 vs

(* remove value v from list l *)
let rec remove_from_list v = function
    [] -> []
  | v' :: vs' ->
      if v' = v then (remove_from_list v vs')
      else v' :: (remove_from_list v vs')

(* remove a value v from the mappings of key k *)
let rec remove_value k v d =
  match d with
    [] -> []
  | (k', vs') :: d' ->
      if k' = k then
        let vs'' = remove_from_list v vs' in
        (k', vs'') :: d'
      else (k', vs') :: (remove_value k v d')

(* remove the value v from all mappings in d *)
let remove_value_from_all_mappings v d =
  let rec loop ks v d =
    match ks with
      [] -> d
    | k' :: ks' -> let d' = remove_value k' v d in loop ks' v d'
  in
  loop (keyset d) v d

(* remove k as a key from dictionary d. All mappings from k will be gone. *)
let rec remove_key k d =
  match d with
    [] -> []
  | (k', vs') :: d' ->
      if k' = k then d'
      else (k', vs') :: (remove_key k d')


(* utility function to allow creating a dict out of a list representation. *)
let of_list l =
  List.fold_left (fun d' (k, vs) -> add_values k vs d') (make_dict ()) l

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
  loop ks (make_dict ())

