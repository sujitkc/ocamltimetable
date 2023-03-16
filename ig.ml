module D = Dict
module G = Graph
module IntSet = Set.Make(Int)

let get k d =
  match D.get k d with
    None -> []
  | Some(vs) -> vs

let convert d =
  let g = G.make_graph () in
  let keys = D.keyset d in
  let rec loop1 i g =
    if i = List.length keys - 1 then g
    else
      let ki = List.nth keys i in
      let seti = IntSet.of_list (get ki d) in
      let rec loop2 j g =
        if j = List.length keys then loop1 (i + 1) g
        else
          let kj = List.nth keys j in
          let vsj = get kj d in
          let setj = IntSet.of_list vsj in
          let setij = IntSet.inter seti setj in
          let g' =
            if IntSet.is_empty setij then g
            else g |> (G.add_node ki) |> G.add_node kj |> (G.add_edge ki kj)
          in
          loop2 (j + 1) g'
      in
      loop2 (i + 1) g
  in
  loop1 0 g


