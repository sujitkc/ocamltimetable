exception GCException of int

module Stack :
sig
  val push : 'a -> 'a list -> 'a list
  val pop : 'a list -> 'a * 'a list
  val make : unit -> 'a list
  val is_empty : 'a list -> bool
end

module AssociativeArray :
sig
  val make : unit -> 'a list
  val add : 'a -> 'b -> ('a * 'b) list -> ('a * 'b) list
  val get : 'a -> ('a * 'b) list -> 'b
  val to_string : (int * int) list -> string
end

val graph_colour : (int * int list) list -> (int * int) list
