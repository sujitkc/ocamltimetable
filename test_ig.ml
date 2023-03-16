module D = Dict
module G = Graph

(* invert *)
let t1 () =
  let d = D.of_list [(1, [2; 3]); (4, [3; 6; 7]); (8, [7])] in
  print_endline ("D = " ^ D.string_of_dict d);
  print_endline ("G = " ^ G.string_of_graph (Ig.convert d))

let t () =
  t1 ()

let _ = t ()
