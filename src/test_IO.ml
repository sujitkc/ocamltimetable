module D = Dict

(* TEST CASES *)
let string_of_csv data =
  let string_of_row row = (List.fold_left (fun s c ->  s ^ ", " ^ c) "" row) ^ "\n" in
  let string_of_rows rows = List.fold_left (fun rs r -> rs ^ (string_of_row r)) "" rows in
  string_of_rows data

let t1 () =
  let data = IO.read "../data/ex1.csv" in
  let strrow row = List.map string_of_int row in
  let strdata = List.map strrow data in
  print_endline (string_of_csv strdata)

let t2 () =
  let d = IO.to_dict "../data/ex1.csv" in
  print_endline (D.string_of_dict d)

let t () =
  t1 (); t2 ()

let _ = t ()
