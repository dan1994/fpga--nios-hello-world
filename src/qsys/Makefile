include base.mk

.PHONY: all qsys_gen clean clean_all

all: qsys_gen

qsys_gen: ${QSYS_OBJ}

${QSYS_OBJ}: ${QSYS_SRCFILE}
	${QSYS_GEN} ${QSYS_SRCFILE} ${QSYS_GEN_FLAGS}
	mv ${SOPCINFO_FILENAME} ${SOPCINFO_FILEPATH}

clean:
	rm -rf ${QSYS_OBJ}

clean_all:
	rm -rf ${QSYS_BUILD_DIR}