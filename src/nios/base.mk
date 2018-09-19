# The base path of the project
BASE_PATH					:=$(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST))))../..;pwd)

# Included for SOPCINFO file
include ${BASE_PATH}/src/qsys/base.mk

# Src and build dirs
NIOS_SRC_DIR				:=${BASE_PATH}/src/nios
NIOS_BUILD_DIR				:=${BASE_PATH}/build/nios

# Project creation details
NIOS_PROJECT_NAME			:=hello_world
DESIGN_EXAMPLE				:=hello_world_small
APP_DIR						:=${NIOS_BUILD_DIR}/${NIOS_PROJECT_NAME}
BSP_DIR						:=${APP_DIR}_bsp
CPU_NAME					:=nios

# Srcs
NIOS_SRCS					:=${NIOS_SRC_DIR}/$(wildcard *.c)

# Objs
NIOS_PROJECTS				:=${BSP_DIR} ${APP_DIR}
APP_MAKEFILE				:=${APP_DIR}/Makefile
ELF_FILE					:=${APP_DIR}/${NIOS_PROJECT_NAME}.elf
MEMINIT_DIR					:=${APP_DIR}/mem_init
MEMINIT_QIP					:=${MEMINIT_DIR}/meminit.qip
NIOS_OBJ					:=${APP_DIR}/${NIOS_PROJECT_NAME}.* ${APP_DIR}/obj/ ${MEMINIT_DIR}

# Commands
NIOS_EXAMPLE_GEN			:=nios2-swexample-create
NIOS_EXAMPLE_GEN_FLAGS		:=--name=${NIOS_PROJECT_NAME} --sopc-file=${SOPCINFO_FILEPATH} --type=${DESIGN_EXAMPLE} --app-dir=${APP_DIR} --bsp-dir=${BSP_DIR} --cpu-name=${CPU_NAME}

NIOS_MAKEFILE_UPDATE		:=nios2-app-update-makefile
NIOS_MAKEFILE_UPDATE_FLAGS	:=--app-dir ${APP_DIR} --add-src-rdir . --remove-src-files hello_world_small.c
