include base.mk
include ${BASE_PATH}/src/qsys/base.mk
include ${BASE_PATH}/src/nios/base.mk

.PHONY: all compile quartus_proj clean clean_all

# Compile the project
compile: ${SOF_FILE}

${SOF_FILE}: ${QPF_FILE} ${QSF_FILE} ${QSYS_OBJ} ${MEMINIT_DIR}
	${QUARTUS_SH} --flow compile ${QPF_FILE}

# Generate NIOS qip
${MEMINIT_DIR}:
	make -C ${BASE_PATH}/src/nios/ mem_init_generate

# Generate QSys qip
${QSYS_OBJ}:
	make -C ${BASE_PATH}/src/qsys all

# Create Quartus project
quartus_proj: ${QPF_FILE} ${QSF_FILE}

${QPF_FILE}:
	mkdir -p ${PNR_BUILD_DIR}
	cd ${PNR_BUILD_DIR}; ${QUARTUS_SH} ${QUARTUS_SH_PREPARE_FLAGS}

${QSF_FILE}: ${TCL_SRCS} ${FILES_TCL_FILEPATH}
	${QUARTUS_SH} -t main.tcl ${QPF_FILE} ${FILES_TCL_FILEPATH}

# Gather RTL srcs into files.tcl
${FILES_TCL_FILEPATH}: ${RTL_SRCS}
	cd ${PNR_PROJECT_SRC_DIR}; ./gather_src_files.py -t ${TOP_LEVEL} -q ${QSYS_QIP} -m ${MEMINIT_QIP} -o ${FILES_TCL_FILEPATH} ${RTL_SRC_DIR}

clean:
	rm -rf ${QUARTUS_OBJ}

clean_all:
	rm -rf ${PNR_BUILD_DIR}
