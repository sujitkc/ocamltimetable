module D = Dict
module G = Graph
module T = Timetable
module A = Gc.AssociativeArray

(* TEST CASES *)

let t1 () =
  let reg = D.of_list [(1, [3; 6]); (2, [3; 5; 6]); (3, [4; 5; 6]); (4, [5; 6]); (5, [6])] in
  let cmap = T.generate reg in
  print_endline (A.to_string cmap)

let t2 () =
  let cmap = T.main "data/ex1.csv" in
  print_endline (A.to_string cmap)

let t () =
        t1 (); t2 ()

let _ = t ()
