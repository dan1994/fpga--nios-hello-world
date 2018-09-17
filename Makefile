ROOT_DIR=/mnt/c/intelFPGA_lite/18.0
QUARTUS_SH=${ROOT_DIR}/quartus/bin64/quartus_sh.exe
QSYS_GEN=${ROOT_DIR}/quartus/sopc_builder/bin/qsys-generate.exe
PGM=${ROOT_DIR}/quartus/bin64/quartus_pgm.exe
LOG_DIR=logs

fast_burn:
	${PGM} -c "Cyclone 10 LP Evaluation Kit [USB-1]" qts/burn.cdf > ${LOG_DIR}/burn.log 2>&1

burn: pnr/output_files/hello_world.sof
	${PGM} -c "Cyclone 10 LP Evaluation Kit [USB-1]" qts/burn.cdf > ${LOG_DIR}/burn.log 2>&1

compile: pnr/output_files/hello_world.sof

pnr/output_files/hello_world.sof: pnr/hello_world.qpf qsys/nios_setup/synthesis/nios_setup.qip nios/hello_world/mem_init/meminit.qip $(wildcard src/*.sv)
	${QUARTUS_SH} --flow compile pnr/hello_world > ${LOG_DIR}/compile.log 2>&1

quartus_proj: pnr/hello_world.qpf

pnr/hello_world.qpf: $(wildcard qts/*)
	rm -rf pnr
	mkdir -p pnr
	cd pnr; ${QUARTUS_SH} --prepare -f "Cyclone 10 LP" -d 10CL025YU256I7G -t top hello_world > ../${LOG_DIR}/create_project.log 2>&1
	${QUARTUS_SH} -t qts/main.tcl > ${LOG_DIR}/source_tcl.log 2>&1

compile_sw: nios/hello_world/mem_init/meminit.qip

nios/hello_world/mem_init/meminit.qip: qsys/nios_setup/synthesis/nios_setup.qip nios/hello_world/hello_world_small.c
	$(error ERROR: NIOS software compilation currently not supported in Makefile. Please compile through Eclipse)

qsys_gen: qsys/nios_setup/synthesis/nios_setup.qip

qsys/nios_setup/synthesis/nios_setup.qip: qsys/nios_setup.qsys
	${QSYS_GEN} qsys/nios_setup.qsys --synthesis=VERILOG --output-directory="qsys/nios_setup" --family="Cyclone 10 LP" --part=10CL025YU256I7G > ${LOG_DIR}/gen_qsys.log 2>&1

clear_logs:
	rm ${LOG_DIR}/*