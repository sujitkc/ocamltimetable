module G = Graph
module A = Gc.AssociativeArray

(* TEST CASES *)

let t1 () =
  let g = G.of_list [(1, [3; 6]); (2, [3; 5; 6]); (3, [4; 5; 6]); (4, [5; 6]); (5, [6])] in
  let cmap = Gc.graph_colour g in
  print_endline (A.to_string cmap)

let t2 () =
  let g = G.of_list [(1, []); (2, []); (3, []); (4, []); (5, [])] in
  print_endline (G.string_of_graph g);
  let cmap = Gc.graph_colour g in
  print_endline (A.to_string cmap)


let t () =
   t1 (); t2 ()

let _ = t ()
