include ../project/base.mk

PGM=quartus_pgm
CABLE="Cyclone 10 LP Evaluation Kit [USB-1]"

fast_burn:
	${PGM} -c ${CABLE} burn.cdf

burn: ${SOF_FILE}
	${PGM} -c ${CABLE} burn.cdf
