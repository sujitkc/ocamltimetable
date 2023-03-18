module D = Dict

(* TEST CASES *)
(* add *)
let t1 () =
  let d1 = D.make_dict () in
  let d2 = D.add 1 2 d1 in
  let d3 = D.add 3 4 d2 in
  let d4 = D.add 1 5 d3 in
  print_endline (D.string_of_dict d4)

(* of_list *)
let t2 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  print_endline (D.string_of_dict d)

(* invert *)
let t3 () =
  let d = D.of_list [(1, [2; 3]); (4, [3; 6; 7]); (8, [7])] in
  print_endline (D.string_of_dict (D.invert d))

(* add_values_as_keys *)
let t4 () =
  let d1 = D.add_values_as_keys 1 [2; 3] (D.make_dict ()) in
  let d2 = D.add_values_as_keys 4 [2; 5] d1 in
  print_endline (D.string_of_dict d2)

(* get *)  
let test_key k d =
  let vs = D.get k d in
  match vs with
    None -> print_endline "key not found."
  | Some(vs') -> print_endline ("d[" ^ (D.string_of_key k) ^ "] = " ^ (D.string_of_values vs'))

let t5 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])]
  and k = 1 in
  test_key k d

let t6 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])]
  and k = 5 in
  test_key k d

(* add_values *)
let t7 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  let d1 = D.add_values 1 [10; 11] d in
  print_endline (D.string_of_dict d1)

(* keys_of_value *)
let t8 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  let d' = D.invert d in
  let keys4 = D.keys_of_value 4 d' in
  print_endline (D.string_of_values keys4)

(* remove_value_from_all_mappings *)
let t9 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  let d' = D.invert d in
  let d'' = D.remove_value_from_all_mappings 4 d' in
  print_endline ("Before removal : " ^ (D.string_of_dict d'));
  print_endline ("After removal : " ^ (D.string_of_dict d''))

(* remove_key *)
let t10 () =
  let d = D.of_list [(1, [2; 3]); (4, [5; 6; 7]); (8, [9])] in
  let d' = D.remove_key 4 d in
  print_endline (D.string_of_dict d')

let test () =
  t1 (); t2 (); t3 (); t4 (); t5 ();
  t6 (); t7 (); t8 (); t9 (); t10 ()

let _ = test ()
