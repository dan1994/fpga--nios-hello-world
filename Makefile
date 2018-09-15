ROOT_DIR=/mnt/c/intelFPGA_lite/18.0
QUARTUS_SH=${ROOT_DIR}/quartus/bin64/quartus_sh.exe
QSYS_GEN=${ROOT_DIR}/quartus/sopc_builder/bin/qsys-generate.exe

quartus_proj:
	rm -rf pnr
	mkdir -p pnr
	cd pnr; ${QUARTUS_SH} --prepare -f "Cyclone 10 LP" -d 10CL025YU256I7G -t top hello_world > /dev/null
	${QUARTUS_SH} -t top/main.tcl -project hello_world > /dev/null

qsys_gen:
	${QSYS_GEN} qsys/nios_setup.qsys --synthesis=VERILOG --output-directory="qsys/nios_setup" --family="Cyclone 10 LP" --part=10CL025YU256I7G > /dev/null