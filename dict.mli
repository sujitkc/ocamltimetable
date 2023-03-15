(* create a new empty dict *)
val make_dict : unit -> 'a list

(* get the list of keys in dict d *)
val keyset :('a * 'b) list -> 'a list

(* Add a key value pair (k, v) to the given dict d. *)
val add : 'a -> 'b -> ('a * 'b list) list -> ('a * 'b list) list

(* Get the values corresponding to the key k in the given dict d *)
val get : 'a -> ('a * 'b) list -> 'b option

(* Add a list vs of values for a given key k to a dict d. *)
val add_values : 'a -> 'b list -> ('a * 'b list) list -> ('a * 'b list) list

(* utility function to allow creating a dict out of a list representation. *)
val of_list : ('a * 'b list) list -> ('a * 'b list) list

(* invert the dict d *)
val invert : ('a * 'b list) list -> ('b * 'a list) list
