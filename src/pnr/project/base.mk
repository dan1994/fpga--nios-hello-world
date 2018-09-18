# The base path of the project
BASE_PATH					:=$(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST))))../../..;pwd)

# Src and build dirs
RTL_SRC_DIR					:=${BASE_PATH}/src/rtl
PNR_PROJECT_SRC_DIR 		:=${BASE_PATH}/src/pnr/project
PNR_BUILD_DIR				:=${BASE_PATH}/build/pnr

# Project creation details
FPGA_FAMILY					:="Cyclone 10 LP"
FPGA_PART					:=10CL025YU256I7G
TOP_LEVEL					:=top
QUARTUS_PROJECT_NAME		:=hello_world

# Srcs
TCL_SRCS					:=$(wildcard ${PNR_PROJECT_SRC_DIR}/*.tcl)
RTL_SRCS					:=$(wildcard ${RTL_SRC_DIR}/*.vhd ${RTL_SRC_DIR}/*.vhdl ${RTL_SRC_DIR}/*.v ${RTL_SRC_DIR}/*.sv)

# Objs
FILES_TCL_FILENAME			:=files.tcl
FILES_TCL_FILEPATH			:=${PNR_BUILD_DIR}/${FILES_TCL_FILENAME}
QPF_FILE					:=${PNR_BUILD_DIR}/${QUARTUS_PROJECT_NAME}.qpf
QSF_FILE					:=${PNR_BUILD_DIR}/${QUARTUS_PROJECT_NAME}.qsf
QUARTUS_OBJ					:=${PNR_BUILD_DIR}/output_files
SOF_FILE					:=${QUARTUS_OBJ}/${QUARTUS_PROJECT_NAME}.sof

# Commands
QUARTUS_SH					:=quartus_sh
QUARTUS_SH_PREPARE_FLAGS	:=--prepare -f ${FPGA_FAMILY} -d ${FPGA_PART} -t ${TOP_LEVEL} ${QUARTUS_PROJECT_NAME}
