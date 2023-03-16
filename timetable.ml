module D = Dict

let generate reg =
  reg |> D.invert |> Ig.convert |> Gc.graph_colour
