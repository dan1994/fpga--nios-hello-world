BASE_PATH:=$(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST))));pwd)

.PHONY: all fast_burn burn compile quartus_proj mem_init_generate qsys_gen clean clean_all

all: compile

fast_burn:
	make -C ${BASE_PATH}/src/pnr/burning fast_burn

burn:
	make -C ${BASE_PATH}/src/pnr/burning burn

compile:
	make -C ${BASE_PATH}/src/pnr/project

quartus_proj:
	make -C ${BASE_PATH}/src/pnr/project quartus_proj

mem_init_generate:
	make -C ${BASE_PATH}/src/nios

qsys_gen:
	make -C ${BASE_PATH}/src/qsys

clean:
	make -C ${BASE_PATH}/src/pnr/project clean
	make -C ${BASE_PATH}/src/nios clean
	make -C ${BASE_PATH}/src/qsys clean

clean_all:
	rm -rf ${BASE_PATH}/build