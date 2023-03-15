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

val remove_next :
  int -> (int * int list) list -> int * int list * (int * int list) list

val remove_all :
  int -> (int * int list) list -> (int * int list) list * int list

val max : 'a list -> 'a

val min_feasible_colour : int list -> int

val colour_node : int -> (int * int list) list -> (int * int) list -> int

val restore_node :
  int ->
  (int * int list) list ->
  (int * int list) list ->
  int -> (int * int) list -> int * (int * int list) list

val restore_all :
  (int * int list) list ->
  (int * int list) list -> int list -> int -> (int * int) list

val k_colour : int -> (int * int list) list -> (int * int) list

val graph_colour : (int * int list) list -> (int * int) list
