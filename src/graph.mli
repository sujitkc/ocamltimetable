val make_graph : unit -> 'a list

val all_nodes : ('a * 'b) list -> 'a list

val not_keys : (int * int list) list -> int list

val add_node : 'a -> ('a * 'b list) list -> ('a * 'b list) list

val add_nodes : 'a list -> ('a * 'b list) list -> ('a * 'b list) list

val of_list : (int * int list) list -> (int * int list) list

val num_of_nodes : ('a * 'b) list -> int

val has_node : 'a -> ('a * 'b) list -> bool

val string_of_node : int -> string

val string_of_nodes : int list -> string

val string_of_graph : (int * int list) list -> string

val all_neighbours : int -> (int * int list) list -> int list

val num_of_neighbours : int -> (int * int list) list -> int

val are_neighbours : int -> int -> (int * int list) list -> bool

val add_edge : int -> int -> (int * int list) list -> (int * int list) list

val add_edges :
  int -> (int * int list) list -> int list -> (int * int list) list

val remove_node : 'a -> ('a * 'a list) list -> ('a * 'a list) list

