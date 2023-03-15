#use "graph.ml"

(* PSEUDO-CODE
 *
  while g is not empty do
    for each node n in g such that |neighbours n| < k do
      nbrs[n] = all_neighbours n
      remove n from g
      push n to stack
    done
  done

  while stack is not empty do
    n = pop stack
    add n back to g and connect it to all n' in nbrs[n]
    colour[n] = minimum feasible colour
  done

  minimum feasible colour = minimum colour(-code) that can be given
  to a node so as it is not given to any of its existing neighbours.
   

*)

exception GCException of int

module D = Dict
module G = Graph

let remove_next k g =
  let nodes = G.all_nodes g in
  let sorted = List.sort 
    (fun n1 n2 ->
       let nbrs1 = G.all_neighbours n1 g
       and nbrs2 = G.all_neighbours n2 g in
       let num1 = List.length nbrs1
       and num2 = List.length nbrs2 in
       Int.compare num1 num2
     ) nodes in
  let next_node = List.nth sorted 0 in
  let nbrs = G.all_neighbours next_node g in
  if (List.length nbrs) < k then
    let g' = G.remove_node next_node g in
    (next_node, nbrs, g')
  else raise (GCException k)

let remove_all k g =
  let rec loop g nbrs_dict stack =
    if G.num_of_nodes g = 0 then
      (nbrs_dict, stack)
    else
      let nn, nbrs', g' = remove_next k g in
      let nbrs_dict' = D.add_values nn nbrs' nbrs_dict in
      (loop g nbrs_dict' (nn :: stack))
  in
  let nbrs_dict0 = D.make_dict () in
  loop g nbrs_dict0 []

(* returns a list of pairs of node, colour, if successful, else fails  *)
let k_colour col g = ()
 
(* Starts with k = 1 and goes upto k = number_of_nodes in g and tries to
 * k_colour g *)
let graph_colour g =
  let n = G.num_of_nodes g in
  let rec iter k g =
    try
      k_colour k g
    with
      Failure(_) ->
        if k = n then failwith ("failed to colour.")
        else iter (k + 1) g
   in
   iter 1 g
