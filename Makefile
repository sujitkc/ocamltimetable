dict.cmi : dict.mli
	ocamlc -c dict.mli

dict.cmo : dict.ml dict.cmi
	ocamlc -c dict.ml

test_dict.cmo : test_dict.ml dict.cmo
	ocamlc -c test_dict.ml

test_dict : test_dict.cmo
	ocamlc -o test_dict dict.cmo test_dict.cmo

graph.cmi : graph.mli
	ocamlc -c graph.mli

graph.cmo : graph.ml graph.cmi dict.cmi
	ocamlc -c graph.ml

test_graph.cmo : test_graph.ml dict.cmi
	ocamlc -c test_graph.ml

test_graph : test_graph.cmo graph.cmo dict.cmo
	ocamlc -o test_graph dict.cmo graph.cmo test_graph.cmo

gc.cmi : gc.mli
	ocamlc -c gc.mli

gc.cmo : gc.ml gc.cmi graph.cmi dict.cmi
	ocamlc -c gc.ml

test_gc.cmo : test_gc.ml graph.cmi dict.cmi gc.cmi
	ocamlc -c test_gc.ml

test_gc : dict.cmo graph.cmo gc.cmo test_gc.cmo
	ocamlc -o test_gc dict.cmo graph.cmo gc.cmo test_gc.cmo

clean:
	rm *.cmo *.cmi test_dict
