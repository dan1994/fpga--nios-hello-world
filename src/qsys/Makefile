include base.mk

qsys_gen: ${QSYS_OBJ}

${QSYS_OBJ}: ${QSYS_SRC}
	${QSYS_GEN} ${QSYS_SRC} ${QSYS_GEN_FLAGS}
	mv ${SOPCINFO_FILE} ${QSYS_BUILD_DIR}

clean:
	rm -rf ${QSYS_OBJ}