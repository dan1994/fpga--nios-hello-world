ROOT_DIR=/mnt/c/intelFPGA_lite/18.0
QUARTUS_SH=${ROOT_DIR}/quartus/bin64/quartus_sh.exe
QSYS_GEN=${ROOT_DIR}/quartus/sopc_builder/bin/qsys-generate.exe
PGM=${ROOT_DIR}/quartus/bin64/quartus_pgm.exe
LOG_DIR=logs

burn: pnr/output_files/hello_world.sof
	${PGM} -c "Cyclone 10 LP Evaluation Kit [USB-1]" top/burn.cdf > ${LOG_DIR}/burn.log 2>&1

compile: pnr/output_files/hello_world.sof

pnr/output_files/hello_world.sof: pnr/hello_world.qpf qsys/nios_setup/synthesis/nios_setup.v $(wildcard top/*.sv)
	${QUARTUS_SH} --flow compile pnr/hello_world > ${LOG_DIR}/compile.log

quartus_proj: pnr/hello_world.qpf

pnr/hello_world.qpf: $(wildcard top/*.tcl)
	rm -rf pnr
	mkdir -p pnr
	cd pnr; ${QUARTUS_SH} --prepare -f "Cyclone 10 LP" -d 10CL025YU256I7G -t top hello_world > ../${LOG_DIR}/create_project.log 2>&1
	${QUARTUS_SH} -t top/main.tcl > ${LOG_DIR}/source_tcl.log 2>&1

qsys_gen: qsys/nios_setup/synthesis/nios_setup.v

qsys/nios_setup/synthesis/nios_setup.v: qsys/nios_setup.qsys
	${QSYS_GEN} qsys/nios_setup.qsys --synthesis=VERILOG --output-directory="qsys/nios_setup" --family="Cyclone 10 LP" --part=10CL025YU256I7G > ${LOG_DIR}/gen_qsys.log 2>&1

clear_logs:
	rm ${LOG_DIR}/*