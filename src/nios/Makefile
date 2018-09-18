include base.mk
include ../qsys/base.mk

# Compile to hex
mem_init_generate: sw_gen ${MEMINIT_DIR}

${MEMINIT_DIR}: $(wildcard *.c)
	make -C ${APP_DIR} mem_init_generate

# Compile to elf
compile: sw_gen ${ELF_FILE}

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