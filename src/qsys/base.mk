QSYS_BUILD_DIR=../../build/qsys

QSYS_NAME=nios_setup
QSYS_SRC=${QSYS_NAME}.qsys
SOPCINFO_FILE=${QSYS_NAME}.sopcinfo
QSYS_OUT_DIR=${QSYS_BUILD_DIR}/${QSYS_NAME}
QSYS_OBJ=	${QSYS_OUT_DIR}\
			${QSYS_BUILD_DIR}/${SOPCINFO_FILE}

QSYS_GEN=qsys-generate
QSYS_GEN_FLAGS=--synthesis=VERILOG --output-directory="${QSYS_OUT_DIR}" --family="Cyclone 10 LP" --part=10CL025YU256I7G