#use "dict.ml"

module Graph =
struct
  module D = Dict

  let make_graph = D.make_dict

  let all_nodes = D.keyset

  let num_of_nodes g = List.length (all_nodes g)

  let not_keys d =
    let ks = D.keyset d in
    let rec iter = function
        [] -> []
      | k' :: ks' ->
          match D.get k' d with
            None ->
              failwith
                ("Graph.not_key : " ^ (D.string_of_key k') ^ " not found.")
          | Some(vs) ->
              (List.filter (fun v -> (List.mem v ks) = false) vs)
              @
              (iter ks')
    in
    iter ks

  (* add a new node n to graph g (if it already doesn't exist). *)
  let add_node n = D.add_values n []

  let of_list l =
    let g = D.of_list l in
    let nks = not_keys g in
    let rec iter g = function
        [] -> g
      | nk' :: nks' ->
          let g' = (add_node nk' g) in (iter g' nks')
    in
    iter g nks

  let num_of_nodes g = List.length (D.keyset g)

  let has_node n g = List.mem n (D.keyset g)

  let string_of_node = D.string_of_key

  let string_of_nodes = D.string_of_values

  let string_of_graph = D.string_of_dict

  (* return all neighbours of node n. *)
  let all_neighbours n g =
    let vs =
      match D.get n g with
        None -> failwith ("Graph.all_neighbours: node " ^ 
                           (string_of_node n) ^ " not there.")
      | Some(vs') -> vs'
    in
    vs @ (D.keys_of_value n g)

  (* returns true if n1 and n2 are neighbours in graph g; else false. *)
  let are_neighbours n1 n2 g = List.mem n2 (all_neighbours n1 g)

  (* add a new edge (n1, n2) to graph g if already doesn't exist. *)
  let add_edge n1 n2 g =
    if are_neighbours n1 n2 g then g
    else D.add n1 n2 g

  (*
    Remove a node as key and remove it as value from
    all mappings where it's a value. 
  *)
  let remove_node n g =
    let g' = D.remove_key n g in
    D.remove_value_from_all_mappings n g'

end (* Module Graph *)

(* make_graph *)
let tgraph_1 () =
  let g = Graph.make_graph ()
  in
  ()

(* add_node *)
let tgraph_2 () =
  let g1 = Graph.make_graph () in
  let g2 = Graph.add_node 1 g1 in
  print_endline (Graph.string_of_graph g2)

(* of_list, all_neighbours *)
let tgraph_3 () =
  let g = Graph.of_list [(1, [2]); (2, [3; 4]); (3, [4]); (4, [1])] in
  print_endline (Graph.string_of_nodes (Graph.all_neighbours 3 g));
  print_endline (Graph.string_of_nodes (Graph.all_neighbours 4 g))

(* of_list *)
let tgraph_4 () =
  let g = Graph.of_list [(1, [2]); (2, [3; 4]); (3, [4])] in
  print_endline (Graph.string_of_graph g)

(* remove_node *)
let tgraph_5 () =
  let g = Graph.of_list [(1, [2]); (2, [3; 4]); (3, [4])] in
  let g' = Graph.remove_node 4 g in
  print_endline (Graph.string_of_graph g')