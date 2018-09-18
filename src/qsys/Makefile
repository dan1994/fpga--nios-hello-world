include base.mk

qsys_gen: ${QSYS_OBJ}

${QSYS_OBJ}: ${QSYS_SRC}
	${QSYS_GEN} ${QSYS_SRC} ${QSYS_GEN_FLAGS}
	mv ${SOPCINFO_FILENAME} ${SOPCINFO_FILEPATH}

clean:
	rm -rf ${QSYS_OBJ}