module D = Dict

let int_of_string_csv data =
  let int_row row = List.map int_of_string row in
  List.map int_row data

let read fname  =
  let flist_csv = Csv.load fname in
  int_of_string_csv flist_csv

let to_dict fname =
  let icsv = read fname in
  let paired_rows = List.map
                      (
                        fun row ->
                          match row with
                            [] -> failwith "IO.to_dict: empty row"
                          | i :: is -> (i, is)
                      )
                      icsv in
  List.fold_left
    (
      fun d pr ->
        let (k, vs) = pr in
        D.add_values k vs d
    )
    (D.make_dict ()) paired_rows
