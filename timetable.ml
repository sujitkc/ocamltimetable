module D = Dict

let generate reg =
  reg |> D.invert |> Ig.convert |> Gc.graph_colour

let main fname =
  fname |> IO.to_dict |> generate
