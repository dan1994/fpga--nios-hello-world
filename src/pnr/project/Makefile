include base.mk
include ../../qsys/base.mk
include ../../nios/base.mk

compile: ${SOF_FILE}

${SOF_FILE}: quartus_proj qsys_gen mem_init_generate ${SRCS}
	${QUARTUS_SH} --flow compile ${QPF_FILE}

mem_init_generate:
	make -C ../../nios/ mem_init_generate

qsys_gen:
	make -C ../../qsys qsys_gen

quartus_proj: ${QPF_FILE} main.tcl

main.tcl: $(wildcard !(main).tcl) ${FILES_TCL_FILEPATH}
	${QUARTUS_SH} -t main.tcl ${QPF_FILE} ${FILES_TCL_FILEPATH}

${FILES_TCL_FILEPATH}: ${SRCS}
	./gather_src_files.py -t ${TOP_LEVEL} -q ../${QSYS_QIP} -m ../${MEMINIT_QIP} -o ${FILES_TCL_FILEPATH} ${SRC_PATH}

${QPF_FILE}:
	mkdir -p ${PNR_BUILD_DIR}
	cd ${PNR_BUILD_DIR}; ${QUARTUS_SH} ${QUARTUS_SH_PREPARE_FLAGS}

clean:
	rm -rf ${PNR_BUILD_DIR}/*