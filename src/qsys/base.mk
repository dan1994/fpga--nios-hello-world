# The base path of the project
BASE_PATH			:=$(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST))))../..;pwd)

# Included for FPGA family and part details
include ${BASE_PATH}/src/pnr/project/base.mk

# Src and build dirs
QSYS_SRC_DIR		:=${BASE_PATH}/src/qsys
QSYS_BUILD_DIR		:=${BASE_PATH}/build/qsys

# Project name
QSYS_NAME			:=nios_setup

# Srcs
QSYS_SRCFILE		:=${QSYS_SRC_DIR}/${QSYS_NAME}.qsys

# Objs
SOPCINFO_FILENAME	:=${QSYS_NAME}.sopcinfo
SOPCINFO_FILEPATH	:=${QSYS_BUILD_DIR}/${SOPCINFO_FILENAME}
QSYS_OUT_DIR		:=${QSYS_BUILD_DIR}/${QSYS_NAME}
QSYS_QIP			:=${QSYS_OUT_DIR}/synthesis/${QSYS_NAME}.qip
QSYS_OBJ			:=${QSYS_OUT_DIR} ${SOPCINFO_FILEPATH}

# commands
QSYS_GEN			:=qsys-generate
QSYS_GEN_FLAGS		:=--synthesis=VERILOG --output-directory="${QSYS_OUT_DIR}" --family=${FPGA_FAMILY} --part=${FPGA_PART}
