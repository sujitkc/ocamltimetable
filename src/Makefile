CSV=/home/sujitkc/.opam/default/lib/csv
BIN=../bin/
COMPILE=ocamlc -g -I ${BIN}

${BIN}dict.cmi : dict.mli
	${COMPILE} -o ${BIN}dict.cmi -c dict.mli

${BIN}dict.cmo : dict.ml ${BIN}dict.cmi
	${COMPILE} -o ${BIN}dict.cmo -c dict.ml

${BIN}test_dict.cmo : test_dict.ml ${BIN}dict.cmo
	${COMPILE} -o ${BIN}test_dict.cmo -c test_dict.ml

${BIN}test_dict : ${BIN}test_dict.cmo
	${COMPILE} -o ${BIN}test_dict ${BIN}dict.cmo ${BIN}test_dict.cmo

${BIN}graph.cmi : graph.mli
	${COMPILE} -o ${BIN}graph.cmi -c graph.mli

${BIN}graph.cmo : graph.ml ${BIN}graph.cmi ${BIN}dict.cmi
	${COMPILE} -o ${BIN}graph.cmo -c graph.ml

${BIN}test_graph.cmo : test_graph.ml ${BIN}dict.cmi
	${COMPILE} -o ${BIN}test_graph.cmo -c test_graph.ml

${BIN}test_graph : ${BIN}test_graph.cmo ${BIN}graph.cmo ${BIN}dict.cmo
	${COMPILE} -o ${BIN}test_graph ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}test_graph.cmo

${BIN}gc.cmi : gc.mli
	${COMPILE} -o ${BIN}gc.cmi -c gc.mli

${BIN}gc.cmo : gc.ml ${BIN}gc.cmi ${BIN}graph.cmi ${BIN}dict.cmi
	${COMPILE} -o ${BIN}gc.cmo -c gc.ml

${BIN}test_gc.cmo : test_gc.ml ${BIN}graph.cmi ${BIN}dict.cmi ${BIN}gc.cmi
	${COMPILE} -o ${BIN}test_gc.cmo -c test_gc.ml

${BIN}test_gc : ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}gc.cmo ${BIN}test_gc.cmo
	${COMPILE} -o ${BIN}test_gc ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}gc.cmo ${BIN}test_gc.cmo

${BIN}ig.cmi : ig.mli ${BIN}graph.cmi ${BIN}dict.cmi
	${COMPILE} -o ${BIN}ig.cmi -c ig.mli

${BIN}ig.cmo : ig.ml ${BIN}ig.cmi
	${COMPILE} -o ${BIN}ig.cmo -c ig.ml

${BIN}test_ig.cmo : test_ig.ml ${BIN}ig.cmi
	${COMPILE} -o ${BIN}test_ig.cmo -c test_ig.ml

${BIN}test_ig : ${BIN}test_ig.cmo ${BIN}ig.cmo ${BIN}graph.cmo ${BIN}dict.cmo
	${COMPILE} -o ${BIN}test_ig ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}ig.cmo ${BIN}test_ig.cmo

${BIN}timetable.cmi : timetable.mli ${BIN}IO.cmi
	${COMPILE} -o ${BIN}timetable.cmi -c timetable.mli

${BIN}timetable.cmo : timetable.ml ${BIN}timetable.cmi ${BIN}dict.cmi ${BIN}graph.cmi ${BIN}gc.cmi ${BIN}ig.cmi ${BIN}IO.cmi
	${COMPILE} -o ${BIN}timetable.cmo -c timetable.ml

${BIN}test_timetable.cmo : test_timetable.ml ${BIN}timetable.cmi ${BIN}dict.cmi ${BIN}graph.cmi ${BIN}gc.cmi ${BIN}ig.cmi
	${COMPILE} -o ${BIN}test_timetable.cmo -c test_timetable.ml

${BIN}test_timetable : ${BIN}test_timetable.cmo ${BIN}timetable.cmo ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}gc.cmo ${BIN}ig.cmo ${BIN}IO.cmo
	${COMPILE} -o ${BIN}test_timetable ${CSV}/csv.cma ${BIN}dict.cmo ${BIN}graph.cmo ${BIN}gc.cmo ${BIN}ig.cmo ${BIN}IO.cmo ${BIN}timetable.cmo ${BIN}test_timetable.cmo

${BIN}IO.cmi : IO.mli ${BIN}dict.cmi
	${COMPILE} -o ${BIN}IO.cmi -c IO.mli

${BIN}IO.cmo : IO.ml ${BIN}IO.cmi ${BIN}dict.cmi
	${COMPILE} -o ${BIN}IO.cmo -c IO.ml -I ${CSV}

${BIN}test_IO.cmo : test_IO.ml ${BIN}IO.cmo ${BIN}dict.cmi
	${COMPILE} -o ${BIN}test_IO.cmo -c test_IO.ml -I ${CSV}

${BIN}test_IO : ${BIN}test_IO.cmo ${BIN}IO.cmo ${BIN}dict.cmo
	${COMPILE} -o ${BIN}test_IO ${CSV}/csv.cma ${BIN}dict.cmo ${BIN}IO.cmo ${BIN}test_IO.cmo

clean:
	rm ${BIN}/*

lc:
	wc -l *
