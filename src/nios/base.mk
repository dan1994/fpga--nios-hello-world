NIOS_BUILD_DIR=../../build/nios

PROJECT_NAME=hello_world
DESIGN_EXAMPLE=hello_world_small
APP_DIR=${NIOS_BUILD_DIR}/${PROJECT_NAME}
BSP_DIR=${APP_DIR}_bsp
CPU_NAME=nios

NIOS_PROJECTS=${BSP_DIR} ${APP_DIR}

ELF_FILE=${APP_DIR}/${PROJECT_NAME}.elf
MEMINIT_DIR=${APP_DIR}/mem_init
MEMINIT_QIP=${MEMINIT_DIR}/meminit.qip
NIOS_OBJ=${APP_DIR}/${PROJECT_NAME}.* ${APP_DIR}/obj/ ${MEMINIT_DIR}

NIOS_EXAMPLE_GEN=nios2-swexample-create
NIOS_EXAMPLE_GEN_FLAGS=--name=${PROJECT_NAME} --sopc-file=${SOPCINFO_FILEPATH} --type=${DESIGN_EXAMPLE} --app-dir=${APP_DIR} --bsp-dir=${BSP_DIR} --cpu-name=${CPU_NAME}

NIOS_MAKEFILE_UPDATE=nios2-app-update-makefile
NIOS_MAKEFILE_UPDATE_FLAGS=--app-dir ${APP_DIR} --add-src-rdir . --remove-src-files hello_world_small.c
