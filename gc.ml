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

module Stack =
struct
  let push e s = e :: s
  let pop = function
      [] -> failwith "Stack.pop: empty stack"
    | h :: t -> h, t
  let make () = []
  let is_empty s = (List.length s) = 0
end

module AssociativeArray =
struct
  let make () = []
  let add k v aa = (k, v) :: aa
  let rec get k = function
      [] -> print_endline "AA.get failed"; raise Not_found
    | (k', v') :: aa' -> if k = k' then v' else (get k aa')

  let to_string l =
    let string_of_pair (k, v) =
          "(" ^ (string_of_int k) ^ ", " ^ (string_of_int v) ^ ")"
    in
    let strlist = List.map string_of_pair l in
    let str = List.fold_left (fun x y -> x ^ "; " ^ y) "" strlist in
    "[" ^ str ^ "]"
end

module D = Dict
module G = Graph
module S = Stack
module A = AssociativeArray

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
      (loop g' nbrs_dict' (S.push nn stack))
  in
  let nbrs_dict0 = D.make_dict () in
  loop g nbrs_dict0 (S.make ())

(* find the maximum element in the list *)
let max l =
  let rec iter max = function
      [] -> max
    | h :: t -> if max > h then iter max t else iter h t
  in
  match l with
    [] -> raise Not_found
  | _ -> iter (List.hd l) l

(* 
 * compute a minimum colour which is an integer c such
 * (1 <= c <= max cs and c is not in cs) OR c = (max cs) + 1
 * where cs is a list of integer indicating colours.
*)
let min_feasible_colour cs =
  let rec loop c =
    if ((not (List.mem c cs)) || c > (max cs)) then c
    else loop (c + 1)
  in
  loop 1

(* assign colour to node n. Use colour map cmap to compute a good colour. *)
let colour_node n g cmap =
  let nbrs = G.all_neighbours n g in
  let nbr_colours = List.map (fun n' -> A.get n' cmap) nbrs in
  min_feasible_colour nbr_colours

(* add node n to graph g and add edges to all nodes in nbrs_dict 
 * compute the best effort colour col for n. Fail if it's not  good enough. *)
let restore_node n g nbrs_dict k cmap =
  let g' = G.add_node n g in
  let nbrs =
    match D.get n nbrs_dict with
      None -> failwith ("Graph_colour.restore_node: " ^
                          (G.string_of_node n) ^
                          " not found.")
    | Some(nbrs') -> nbrs'
  in
  let g'' = G.add_edges n g' nbrs in
  let col = colour_node n g'' cmap in
  if col <= k then (col, g'')
  else failwith ("Couldn't colour with " ^ (string_of_int k) ^ " colours.")

let restore_all g nbrs_dict stk k =
  let rec loop g stk cmap =
    if S.is_empty stk then cmap
    else
      let n, stk' = S.pop stk in
      let col, g' = restore_node n g nbrs_dict k cmap in
      let cmap' = A.add n col cmap in
      loop g' stk' cmap'
  in
  loop g stk (A.make ())

(* returns a list of pairs of node, colour, if successful, else fails  *)
let k_colour k g =
  let nbrs_dict, stk = remove_all k g in
  let g' = G.make_graph () in
  restore_all g' nbrs_dict stk k

(* Starts with k = 1 and goes upto k = number_of_nodes in g and tries to
 * k_colour g *)
let graph_colour g =
  let n = G.num_of_nodes g in
  let rec iter k g =
    try
      k_colour k g
    with
      GCException(k') ->
        print_endline ("failed to colour with " ^ (string_of_int k'));
        if k = n then failwith ("Graph_colour.graph_colour: failed to colour.")
        else iter (k + 1) g
   in
   iter 1 g

