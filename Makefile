ROOT_DIR=/mnt/c/intelFPGA_lite/18.0
QUARTUS_SH=${ROOT_DIR}/quartus/bin64/quartus_sh.exe
QSYS_GEN=${ROOT_DIR}/quartus/sopc_builder/bin/qsys-generate.exe

compile: qsys_gen quartus_proj
	${QUARTUS_SH} --flow compile pnr/hello_world > logs/compile.log

quartus_proj:
	rm -rf pnr
	mkdir -p pnr
	cd pnr; ${QUARTUS_SH} --prepare -f "Cyclone 10 LP" -d 10CL025YU256I7G -t top hello_world > ../logs/create_project.log 2>&1
	${QUARTUS_SH} -t top/main.tcl -project hello_world > logs/source_tcl.log 2>&1

qsys_gen:
	${QSYS_GEN} qsys/nios_setup.qsys --synthesis=VERILOG --output-directory="qsys/nios_setup" --family="Cyclone 10 LP" --part=10CL025YU256I7G > logs/gen_qsys.log 2>&1

clear_logs:
	rm logs/*