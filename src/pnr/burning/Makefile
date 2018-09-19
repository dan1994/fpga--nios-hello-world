BASE_PATH:=$(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST))))../../..;pwd)

include ${BASE_PATH}/src/pnr/project/base.mk

PGM:=quartus_pgm
PGM_FLAGS:=-c "Cyclone 10 LP Evaluation Kit [1-1]" -m JTAG -o "p;${SOF_FILE}" -o "s;VTAP10"

.PHONY: all fast_burn burn

all: burn

fast_burn:
	${PGM} ${PGM_FLAGS}

burn: ${SOF_FILE}
	${PGM} ${PGM_FLAGS}

${SOF_FILE}:
	make -C ${BASE_PATH}/src/pnr/project
