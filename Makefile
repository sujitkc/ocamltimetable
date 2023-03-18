COMPILE=ocamlc -g
CSV=/home/sujitkc/.opam/default/lib/csv

dict.cmi : dict.mli
	${COMPILE} -c dict.mli

dict.cmo : dict.ml dict.cmi
	${COMPILE} -c dict.ml

test_dict.cmo : test_dict.ml dict.cmo
	${COMPILE} -c test_dict.ml

test_dict : test_dict.cmo
	${COMPILE} -o test_dict dict.cmo test_dict.cmo

graph.cmi : graph.mli
	${COMPILE} -c graph.mli

graph.cmo : graph.ml graph.cmi dict.cmi
	${COMPILE} -c graph.ml

test_graph.cmo : test_graph.ml dict.cmi
	${COMPILE} -c test_graph.ml

test_graph : test_graph.cmo graph.cmo dict.cmo
	${COMPILE} -o test_graph dict.cmo graph.cmo test_graph.cmo

gc.cmi : gc.mli
	${COMPILE} -c gc.mli

gc.cmo : gc.ml gc.cmi graph.cmi dict.cmi
	${COMPILE} -c gc.ml

test_gc.cmo : test_gc.ml graph.cmi dict.cmi gc.cmi
	${COMPILE} -c test_gc.ml

test_gc : dict.cmo graph.cmo gc.cmo test_gc.cmo
	${COMPILE} -o test_gc dict.cmo graph.cmo gc.cmo test_gc.cmo

ig.cmi : ig.mli graph.cmi dict.cmi
	${COMPILE} -c ig.mli

ig.cmo : ig.ml ig.cmi
	${COMPILE} -c ig.ml

test_ig.cmo : test_ig.ml ig.cmi
	${COMPILE} -c test_ig.ml

test_ig : test_ig.cmo ig.cmo graph.cmo dict.cmo
	ocamlc -g -o test_ig dict.cmo graph.cmo ig.cmo test_ig.cmo

timetable.cmi : timetable.mli IO.cmi
	${COMPILE} -c timetable.mli

timetable.cmo : timetable.ml timetable.cmi dict.cmi graph.cmi gc.cmi ig.cmi IO.cmi
	${COMPILE} -c timetable.ml

test_timetable.cmo : test_timetable.ml timetable.cmi dict.cmi graph.cmi gc.cmi ig.cmi
	${COMPILE} -c test_timetable.ml

test_timetable : test_timetable.cmo timetable.cmo dict.cmo graph.cmo gc.cmo ig.cmo IO.cmo
	${COMPILE} -o test_timetable ${CSV}/csv.cma dict.cmo graph.cmo gc.cmo ig.cmo IO.cmo timetable.cmo test_timetable.cmo

IO.cmi : IO.mli dict.cmi
	${COMPILE} -c IO.mli

IO.cmo : IO.ml IO.cmi dict.cmi
	${COMPILE} -c IO.ml -I ${CSV}

test_IO.cmo : test_IO.ml IO.cmo dict.cmi
	${COMPILE} -c test_IO.ml -I ${CSV}

test_IO : test_IO.cmo IO.cmo dict.cmo
	${COMPILE} -o test_IO ${CSV}/csv.cma dict.cmo IO.cmo test_IO.cmo

clean:
	rm *.cmo *.cmi test_dict

lc:
	wc -l *.ml *.mli Makefile
