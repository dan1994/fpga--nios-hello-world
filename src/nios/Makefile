include ../qsys/base.mk

NIOS_BUILD_DIR=../../build/nios

PROJECT_NAME=hello_world
DESIGN_EXAMPLE=hello_world_small
APP_DIR=${NIOS_BUILD_DIR}/${PROJECT_NAME}
BSP_DIR=${APP_DIR}_bsp
CPU_NAME=nios

NIOS_PROJECTS=${BSP_DIR} ${APP_DIR}

NIOS_SRC=*.c
ELF_FILE=${APP_DIR}/${PROJECT_NAME}.elf
MEM_INIT_DIR=${APP_DIR}/mem_init
NIOS_OBJ=${APP_DIR}/${PROJECT_NAME}.* ${APP_DIR}/obj/ ${MEM_INIT_DIR}

NIOS_EXAMPLE_GEN=nios2-swexample-create
NIOS_EXAMPLE_GEN_FLAGS=--name=${PROJECT_NAME} --sopc-file=${QSYS_BUILD_DIR}/${SOPCINFO_FILE} --type=${DESIGN_EXAMPLE} --app-dir=${APP_DIR} --bsp-dir=${BSP_DIR} --cpu-name=${CPU_NAME}

NIOS_MAKEFILE_UPDATE=nios2-app-update-makefile
NIOS_MAKEFILE_UPDATE_FLAGS=--app-dir ${APP_DIR} --add-src-rdir . --remove-src-files hello_world_small.c

# Compile to hex
mem_init_gen: ${NIOS_PROJECTS} ${MEM_INIT_DIR}

${MEM_INIT_DIR}: $(wildcard *.c)
	make -C ${APP_DIR} mem_init_generate

# Compile to elf
compile: ${NIOS_PROJECTS} ${ELF_FILE}
	make -C ${APP_DIR}

 ${ELF_FILE}: $(wildcard *.c)
	make -C ${APP_DIR}

# Create the project
sw_gen: ${QSYS_OBJ} ${NIOS_PROJECTS}

${NIOS_PROJECTS}:
	${NIOS_EXAMPLE_GEN} ${NIOS_EXAMPLE_GEN_FLAGS}
	cd ${BSP_DIR};./create-this-bsp
	cd ${APP_DIR};./create-this-app
	${NIOS_MAKEFILE_UPDATE} ${NIOS_MAKEFILE_UPDATE_FLAGS}
	rm -rf ${APP_DIR}/hello_world_small.c ${NIOS_OBJ}

${QSYS_OBJ}:
	make -C ../qsys qsys_gen

clean:
	rm -rf ${NIOS_OBJ}

clean_all:
	rm -rf ${NIOS_PROJECTS}