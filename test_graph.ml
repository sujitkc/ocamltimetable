module G = Graph

(* make_graph *)
let t1 () =
  let _ = G.make_graph ()
  in
  ()

(* add_node *)
let t2 () =
  let g1 = G.make_graph () in
  let g2 = G.add_node 1 g1 in
  print_endline (G.string_of_graph g2)

(* of_list, all_neighbours *)
let t3 () =
  let g = G.of_list [(1, [2]); (2, [3; 4]); (3, [4]); (4, [1])] in
  print_endline (G.string_of_nodes (G.all_neighbours 3 g));
  print_endline (G.string_of_nodes (G.all_neighbours 4 g))

(* of_list *)
let t4 () =
  let g = G.of_list [(1, [2]); (2, [3; 4]); (3, [4])] in
  print_endline (G.string_of_graph g)

(* remove_node *)
let t5 () =
  let g = G.of_list [(1, [2]); (2, [3; 4]); (3, [4])] in
  let g' = G.remove_node 4 g in
  print_endline (G.string_of_graph g')

let test () =
  t1 (); t2 (); t3 (); t4 (); t5 ()

let _ = test ()
