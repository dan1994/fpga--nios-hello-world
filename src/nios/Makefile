include base.mk
include ${BASE_PATH}/src/qsys/base.mk

.PHONY: all mem_init_generate compile sw_gen clean clean_all

all: mem_init_generate

# Compile to hex
mem_init_generate: sw_gen ${MEMINIT_DIR}

${MEMINIT_DIR}: ${APP_MAKEFILE}
	make -C ${APP_DIR} mem_init_generate

# Compile to elf
compile: sw_gen ${ELF_FILE}

${ELF_FILE}: ${APP_MAKEFILE}
	make -C ${APP_DIR}

# Create the project
sw_gen: ${QSYS_OBJ} ${NIOS_PROJECTS}

${APP_MAKEFILE}: ${NIOS_SRCS}
	${NIOS_MAKEFILE_UPDATE} ${NIOS_MAKEFILE_UPDATE_FLAGS}

${NIOS_PROJECTS}:
	${NIOS_EXAMPLE_GEN} ${NIOS_EXAMPLE_GEN_FLAGS}
	cd ${BSP_DIR};./create-this-bsp
	cd ${APP_DIR};./create-this-app
	${NIOS_MAKEFILE_UPDATE} ${NIOS_MAKEFILE_UPDATE_FLAGS}
	rm -rf ${APP_DIR}/hello_world_small.c ${NIOS_OBJ}

# Generate QSys
${QSYS_OBJ}:
	make -C ${BASE_PATH}/src/qsys

clean:
	rm -rf ${NIOS_OBJ}

clean_all:
	rm -rf ${NIOS_BUILD_DIR}
