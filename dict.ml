let make () = []

let keyset = List.map (fun (x, _) -> x)

let rec add k v d =
  match d with
    [] -> [(k, [v])]
  | (k', l) :: t -> if k = k' then
                      if (List.mem v l = false) then
                        (k, v :: l) :: t
                      else
                        d
                    else
                      (k', l) :: (add k v t)

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

let t1 () =
  let d1 = make () in
  let d2 = add 1 2 d1 in
  let d3 = add 3 4 d2 in
  let d4 = add 1 5 d3 in
  print_endline (string_of_dict d4)
