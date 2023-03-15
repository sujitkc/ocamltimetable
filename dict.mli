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

val has_key : 'a -> ('a * 'b) list -> bool

val add_key : 'a -> ('a * 'b list) list -> ('a * 'b list) list

val keys_of_value : 'a -> ('b * 'a list) list -> 'b list

val remove_from_list : 'a -> 'a list -> 'a list

val remove_value : 'a -> 'b -> ('a * 'b list) list -> ('a * 'b list) list

val remove_value_from_all_mappings :
  'a -> ('b * 'a list) list -> ('b * 'a list) list

val remove_key : 'a -> ('a * 'b) list -> ('a * 'b) list

val string_of_key : int -> string

val string_of_value : int -> string

val string_of_values : int list -> string

val string_of_dict : (int * int list) list -> string

val add_value_as_key :
  'a -> 'b -> ('b * 'a list) list -> ('b * 'a list) list

val add_values_as_keys :
  'a -> 'b list -> ('b * 'a list) list -> ('b * 'a list) list
